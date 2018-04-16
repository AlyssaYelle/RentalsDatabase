# Beam Job Region Table
# Unique Records [zip, city, state, metro, county]
# populate from 1br, 2br...5br csv files

from __future__ import absolute_import

import argparse
import logging
import warnings
import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.options.pipeline_options import SetupOptions
from apache_beam.io.gcp.internal.clients import bigquery



def init_bigquery_table():
	table_schema = bigquery.TableSchema()

	zipcode_field = bigquery.TableFieldSchema()
	zipcode_field.name = 'zipcode'
	zipcode_field.type = 'integer'
	zipcode_field.mode = 'required'
	table_schema.fields.append(zipcode_field)
	
	city_field = bigquery.TableFieldSchema()
	city_field.name = 'city'
	city_field.type = 'string'
	city_field.mode = 'required'
	table_schema.fields.append(city_field)
	
	state_field = bigquery.TableFieldSchema()
	state_field.name = 'state'
	state_field.type = 'string'
	state_field.mode = 'required'
	table_schema.fields.append(state_field)

	metro_field = bigquery.TableFieldSchema()
	metro_field.name = 'metro'
	metro_field.type = 'string'
	metro_field.mode = 'required'
	table_schema.fields.append(metro_field)

	county_field = bigquery.TableFieldSchema()
	county_field.name = 'county'
	county_field.type = 'string'
	county_field.mode = 'required'
	table_schema.fields.append(county_field)
	
	return table_schema;



def create_bigquery_record(tuple):

	# tuple format = (zipcode, city, state, metro, county)
	# For example, (78751, 'Austin', 'TX', 'Austin', 'Travis')
		
	zipcode, city, state, metro, county = tuple
	bq_record = {'zipcode': zipcode, 'city': city, 'state': state, 'metro': metro, 'county': county}
	
	return bq_record


def parse_line(line):
  
	#parsed_records = []

	tokens = line.split(",")
	zipcode_with_quotes = tokens[0]
	zipcode = int(zipcode_with_quotes.strip('"'));
	
	city = tokens[1].strip("")
	state = tokens[2].strip("")
	metro = tokens[3].strip("")
	county = tokens[4].strip("")

	return ((zipcode,city,state,metro,county),tokens[5].strip())

	
def parse_records(records):
	return records[0]

def create_dist(record):
	row, val = record
	return row


def run(argv=None):	
	
	parser = argparse.ArgumentParser()
	known_args, pipeline_args = parser.parse_known_args(argv)
	pipeline_args.extend([	
      '--runner=DataflowRunner', # use DataflowRunner to run on Dataflow or DirectRunner to run on local VM
      '--project=spooky-data-seance', # change to your project_id
      '--staging_location=gs://bayes-the-databae/staging', # change to your bucket
      '--temp_location=gs://bayes-the-databae/temp', # change to your bucket
      '--job_name=bayyyyyesss-region' # assign descriptive name to this job, all in lower case letters
	])
	
	pipeline_options = PipelineOptions(pipeline_args)
	pipeline_options.view_as(SetupOptions).save_main_session = True # save_main_session provides global context
	
	with beam.Pipeline(options=pipeline_options) as p:
	
		table_name = "spooky-data-seance:zillow.Region" # format: project_id:dataset.table
		table_schema = init_bigquery_table()
    
		lines = p | 'ReadFile' >> beam.io.ReadFromText('gs://bayes-the-databae/zillow/Zip_MedianRentalPrice_*.csv')
	
		list_records = lines | 'CreateListRecords' >> (beam.Map(parse_line))

		variable = list_records | beam.GroupByKey()
        
		list_records | 'WriteTmpFile1' >> beam.io.WriteToText('gs://bayes-the-databae/tmp/list_records', file_name_suffix='.txt')
	
		tuple_records = variable | 'CreateTupleRecords' >> (beam.Map(create_dist))
		
		tuple_records | 'WriteTmpFile2' >> beam.io.WriteToText('gs://bayes-the-databae/tmp/tuple_records', file_name_suffix='.txt')

		bigquery_records = tuple_records | 'CreateBigQueryRecord' >> beam.Map(create_bigquery_record)
	
		bigquery_records | 'WriteTmpFile3' >> beam.io.WriteToText('gs://bayes-the-databae/tmp/bq_records', file_name_suffix='.txt')
	
		bigquery_records | 'WriteBigQuery' >> beam.io.Write(
		    beam.io.BigQuerySink(
		        table_name,
		        schema = table_schema,
		        create_disposition = beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
		        write_disposition = beam.io.BigQueryDisposition.WRITE_TRUNCATE))

if __name__ == '__main__':
	warnings.filterwarnings("ignore")
	logging.getLogger().setLevel(logging.DEBUG) # change to INFO or ERROR for less verbose logging
	run()





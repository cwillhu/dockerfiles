#!/usr/bin/env python

from pyspark import SparkConf
from pyspark.sql import SparkSession
from time import sleep
from sys import argv

############################################
# Read table data from SQL Server into Spark
############################################

if __name__ == '__main__':

    conf = SparkConf()
    conf.set('spark.executor.instances', 1)
    conf.set('spark.executor.cores', 4)
    conf.set('spark.executor.memory', '3G')
    conf.set('spark.executor.memoryOverhead', '4G')
    conf.set('spark.dynamicAllocation.enabled', 'false')
    conf.set('spark.network.timeout', '5000s')
    
    spark = SparkSession.builder.config(conf=conf).getOrCreate()
    sleep(5)

    print('readTable_sing.py: read from DB')
    query = 'SELECT TOP 1 * FROM FactICD'
    df = (spark.read.jdbc
          .option('url', argv[1])
          .option('driver', 'com.microsoft.sqlserver.jdbc.SQLServerDriver') 
          .option('query', query)
    )

    df.printSchema()
    df.show()





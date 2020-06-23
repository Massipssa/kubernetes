from airflow import DAG
from airflow.operators import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'massi',
    'depends_on_past': False,
    'start_date': datetime(2019, 10, 26),
    'email': ['kerrache.massipssa@ext.mpsa.com'],
    'retries': 1,
    'retry_delay': timedelta(minutes=1),
}

dag = DAG('test_dag', default_args=default_args)

task_1 = BashOperator(
    task_id='task_1',
    bash_command='echo "Hello World from Task 1"',
    dag=dag)

task_2 = BashOperator(
    task_id='task_2',
    bash_command='echo "Hello World from Task 2"',
    dag=dag)

# 4 - set task dependencies    
task_1 >> task_2 
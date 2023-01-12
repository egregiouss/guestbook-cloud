import boto3

from config import DB_REGION_NAME, DB_ENDPOINT_URL, AWS_ACCESS_KEY_ID, AWS_PRIVATE_KEY


def create_tables(client):

    client.create_table(
        TableName='replica',
        KeySchema=[
            {
                'AttributeName': 'key',
                'KeyType': 'HASH'
            },
        ],
        AttributeDefinitions=[
            {
                'AttributeName': 'key',
                'AttributeType': 'N'
            },
            {
                'AttributeName': 'value',
                'AttributeType': 'N'
            },
        ]
    )
    client.create_table(
        TableName='messages',
        KeySchema=[
            {
                'AttributeName': 'message_id',
                'KeyType': 'HASH'
            },
            {
                'AttributeName': 'author',
                'KeyType': 'RANGE'
            }
        ],
        AttributeDefinitions=[
            {
                'AttributeName': 'message_id',
                'AttributeType': 'S'
            },
            {
                'AttributeName': 'message',
                'AttributeType': 'S'
            },
            {
                'AttributeName': 'author',
                'AttributeType': 'S'
            },
        ]
    )


def add_replica(client):
    table = client.Table('replica')
    table.put_item(
        Item={
            'key': 0,
            'value': 1,
        }
    )
    return table


if __name__ == '__main__':
    ydb_client = boto3.resource('dynamodb',
                                region_name=DB_REGION_NAME,
                                endpoint_url=DB_ENDPOINT_URL,
                                aws_access_key_id=AWS_ACCESS_KEY_ID,
                                aws_secret_access_key=AWS_PRIVATE_KEY)
    create_tables(ydb_client)
    replica_table = add_replica(ydb_client)
    messages_table = ydb_client.Table('messages')

    print("Table(replica) status:", replica_table.table_status)
    print("Table(messages) status:", messages_table.table_status)


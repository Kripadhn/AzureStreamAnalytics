-- Create an Azure Stream Analytics job
CREATE STREAMING JOB [MyStreamingJob]
WITH (
    ACTIVATION_PROCESSING_LAG = 30 SECONDS,
    INPUT_BUFFER_SIZE = 4 MB
);

-- Create an input stream
CREATE INPUT [MyInputStream]
(
    [Id] INT,
    [Name] VARCHAR(100),
    [DateTime] DATETIME
)
FROM EventHub
WITH
(
    PartitionKey = '<partition key>',
    EventHubConnectionString = '<event hub connection string>',
    ConsumerGroup = '<consumer group>'
);

-- Create an output stream
CREATE OUTPUT [MyOutputStream]
TO EventHub
WITH
(
    EventHubConnectionString = '<event hub connection string>',
    PartitionKey = '<partition key>'
);

-- Define the streaming query
SELECT
    [Id],
    [Name],
    [DateTime]
INTO
    [MyOutputStream]
FROM
    [MyInputStream];

-- Start the streaming job
START JOB [MyStreamingJob];

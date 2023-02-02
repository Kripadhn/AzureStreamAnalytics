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
FROM BlobStorage
WITH
(
    Path = '<path to data file>',
    DataFormat = 'JSON',
    StorageAccountKey = '<storage account key>',
    StorageAccountName = '<storage account name>'
);

-- Create an output stream
CREATE OUTPUT [MyOutputStream]
TO BlobStorage
WITH
(
    Path = '<path to output file>',
    DataFormat = 'JSON',
    StorageAccountKey = '<storage account key>',
    StorageAccountName = '<storage account name>'
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

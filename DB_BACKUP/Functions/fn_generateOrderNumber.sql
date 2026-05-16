-- Order number format: O-SequenceNumber (O-000001, O-000002, etc.)
GO
CREATE FUNCTION fn_generateOrderNumber(
    @OutletID UNIQUEIDENTIFIER -- outlet ID require for fetching last sequence number specific to outlet
)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @OrderNumber VARCHAR(20); -- this will return as order number
    DECLARE @LastSequence INT; -- this will fetch last sequence number for the outlet
    DECLARE @NextSeries INT; -- this will calculate next sequence number

    -- Fetch the last sequence number for the specified outlet
    SELECT TOP 1
        @LastSequence = CAST(REPLACE(kotNumber, 'O-', '') AS INT)
    FROM orderHeader
    WHERE OutletID = @OutletID
    ORDER BY CAST(REPLACE(kotNumber, 'O-', '') AS INT) DESC;

    IF @LastSequence IS NULL
    BEGIN
        SET @NextSeries = 1; -- Start from 1 if no previous sequence exists
    END

    ELSE
    BEGIN
        SET @NextSeries = @LastSequence + 1; -- Increment the last sequence number
    END

    -- Generate the order number (simplified example, replace with actual sequence logic)
    SET @OrderNumber = 'O-' + RIGHT('000000' + CAST(@NextSeries AS VARCHAR(6)), 6);

    RETURN @OrderNumber
END
GO

-- SELECT dbo.fn_generateOrderNumber('A1B2C3D4-E5F6-7890-1234-56789ABCDE01') as OrderNumber -- call the function to generate order number for a specific outlet
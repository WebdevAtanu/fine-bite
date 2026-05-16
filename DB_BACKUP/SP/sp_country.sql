CREATE PROCEDURE [dbo].[sp_country]
    (
    @flag VARCHAR(50),
    @countryId UNIQUEIDENTIFIER = NULL,
    @countryName NVARCHAR(50) = NULL,
    @channelId UNIQUEIDENTIFIER = NULL,
    @isActive BIT = 1,
    @loggedUser UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF @flag = 'GETALL'
        BEGIN
        SELECT
            countryId,
            countryName,
            channelId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_country
    END

        ELSE IF @flag = 'GETBYID'
        BEGIN
        SELECT
            countryId,
            countryName,
            channelId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_country
        WHERE countryId = @countryId
    END

        ELSE IF @flag = 'INSERT'
        BEGIN
        IF EXISTS (
                SELECT 1
        FROM m_country
        WHERE countryName = @countryName
            AND channelId = @channelId
            )
            BEGIN
            SELECT 'Country already exists' AS message
            RETURN
        END

        INSERT INTO m_country
            (
            countryId,
            countryName,
            channelId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
            )
        VALUES
            (
                NEWID(),
                @countryName,
                @channelId,
                GETDATE(),
                @loggedUser,
                GETDATE(),
                @loggedUser,
                @isActive
            )
    END

        ELSE IF @flag = 'UPDATE'
        BEGIN
        IF EXISTS (
                SELECT 1
        FROM m_country
        WHERE countryName = @countryName
            AND channelId = @channelId
            AND countryId <> @countryId
            )
            BEGIN
            SELECT 'Country already exists' AS message
            RETURN
        END

        UPDATE m_country
            SET
                countryName = @countryName,
                channelId = @channelId,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser,
                isActive = @isActive
            WHERE countryId = @countryId
    END

        ELSE IF @flag = 'DELETE'
        BEGIN
        UPDATE m_country
            SET
                isActive = 0,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser
            WHERE countryId = @countryId
    END

    END TRY

    BEGIN CATCH
        SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage
    END CATCH

END
GO
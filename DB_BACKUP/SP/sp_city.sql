CREATE PROCEDURE [dbo].[sp_city]
    (
    @flag VARCHAR(50),
    @cityId UNIQUEIDENTIFIER = NULL,
    @cityName NVARCHAR(50) = NULL,
    @channelId UNIQUEIDENTIFIER = NULL,
    @stateId UNIQUEIDENTIFIER = NULL,
    @countryId UNIQUEIDENTIFIER = NULL,
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
            cityId,
            cityName,
            channelId,
            stateId,
            countryId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_city
    END

        ELSE IF @flag = 'GETBYID'
        BEGIN
        SELECT
            cityId,
            cityName,
            channelId,
            stateId,
            countryId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_city
        WHERE cityId = @cityId
    END

        ELSE IF @flag = 'INSERT'
        BEGIN
        IF EXISTS (
                SELECT 1
        FROM m_city
        WHERE cityName = @cityName
            AND channelId = @channelId
            )
            BEGIN
            SELECT 'City already exists' AS message
            RETURN
        END

        INSERT INTO m_city
            (
            cityId,
            cityName,
            channelId,
            stateId,
            countryId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
            )
        VALUES
            (
                NEWID(),
                @cityName,
                @channelId,
                @stateId,
                @countryId,
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
        FROM m_city
        WHERE cityName = @cityName
            AND channelId = @channelId
            AND cityId <> @cityId
            )
            BEGIN
            SELECT 'City already exists' AS message
            RETURN
        END

        UPDATE m_city
            SET
                cityName = @cityName,
                channelId = @channelId,
                stateId = @stateId,
                countryId = @countryId,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser,
                isActive = @isActive
            WHERE cityId = @cityId
    END

        ELSE IF @flag = 'DELETE'
        BEGIN
        UPDATE m_city
            SET
                isActive = 0,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser
            WHERE cityId = @cityId
    END

    END TRY

    BEGIN CATCH
        SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage
    END CATCH

END
GO
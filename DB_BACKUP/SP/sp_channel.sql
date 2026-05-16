CREATE PROCEDURE [dbo].[sp_channel]
    (
    @flag VARCHAR(50),
    @channelId UNIQUEIDENTIFIER = NULL,
    @channelName NVARCHAR(255) = NULL,
    @gstNo NVARCHAR(255) = NULL,
    @panNo NVARCHAR(255) = NULL,
    @fssaiNo NVARCHAR(255) = NULL,
    @address NVARCHAR(255) = NULL,
    @stateId UNIQUEIDENTIFIER = NULL,
    @countryId UNIQUEIDENTIFIER = NULL,
    @districtId UNIQUEIDENTIFIER = NULL,
    @phoneNo NVARCHAR(255) = NULL,
    @emailId NVARCHAR(255) = NULL,
    @website NVARCHAR(255) = NULL,
    @defaultCustomerId UNIQUEIDENTIFIER = NULL,
    @isActive BIT = 1,
    @loggedUser NVARCHAR(255) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF @flag = 'GETALL'
        BEGIN
        SELECT
            channelId,
            channelName,
            gstNo,
            panNo,
            fssaiNo,
            address,
            stateId,
            countryId,
            districtId,
            phoneNo,
            emailId,
            website,
            defaultCustomerId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_channel
    END

        ELSE IF @flag = 'GETBYID'
        BEGIN
        SELECT
            channelId,
            channelName,
            gstNo,
            panNo,
            fssaiNo,
            address,
            stateId,
            countryId,
            districtId,
            phoneNo,
            emailId,
            website,
            defaultCustomerId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_channel
        WHERE channelId = @channelId
            AND isActive = 1
    END

        ELSE IF @flag = 'INSERT'
        BEGIN
        INSERT INTO m_channel
            (
            channelId,
            channelName,
            gstNo,
            panNo,
            fssaiNo,
            address,
            stateId,
            countryId,
            districtId,
            phoneNo,
            emailId,
            website,
            defaultCustomerId,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
            )
        VALUES
            (
                NEWID(),
                @channelName,
                @gstNo,
                @panNo,
                @fssaiNo,
                @address,
                @stateId,
                @countryId,
                @districtId,
                @phoneNo,
                @emailId,
                @website,
                @defaultCustomerId,
                GETDATE(),
                @loggedUser,
                GETDATE(),
                @loggedUser,
                @isActive
            )
    END

        ELSE IF @flag = 'UPDATE'
        BEGIN
        IF @channelId IS NULL
            BEGIN
            RAISERROR('ChannelId is required for UPDATE',16,1)
            RETURN
        END

        UPDATE m_channel
            SET
                channelName = @channelName,
                gstNo = @gstNo,
                panNo = @panNo,
                fssaiNo = @fssaiNo,
                address = @address,
                stateId = @stateId,
                countryId = @countryId,
                districtId = @districtId,
                phoneNo = @phoneNo,
                emailId = @emailId,
                website = @website,
                defaultCustomerId = @defaultCustomerId,
                isActive = @isActive,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser
            WHERE channelId = @channelId
    END

        ELSE IF @flag = 'DELETE'
        BEGIN
        IF @channelId IS NULL
            BEGIN
            RAISERROR('ChannelId is required for DELETE',16,1)
            RETURN
        END

        UPDATE m_channel
            SET
                isActive = 0,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser
            WHERE channelId = @channelId
    END

    END TRY

    BEGIN CATCH
        SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage,
        ERROR_LINE() AS ErrorLine
    END CATCH

END
GO
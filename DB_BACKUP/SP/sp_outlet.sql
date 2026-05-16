CREATE PROCEDURE [dbo].[sp_outlet]
    (
    @flag VARCHAR(50),
    @outletId UNIQUEIDENTIFIER = NULL,
    @outletName NVARCHAR(255) = NULL,
    @outletCode NVARCHAR(255) = NULL,
    @deptId UNIQUEIDENTIFIER = NULL,
    @channelId UNIQUEIDENTIFIER = NULL,
    @phoneNo NVARCHAR(255) = NULL,
    @emailId NVARCHAR(255) = NULL,
    @billPrefix NVARCHAR(255) = NULL,
    @defaultPayModeId UNIQUEIDENTIFIER = NULL,
    @address NVARCHAR(255) = NULL,
    @taxAfterDiscount BIT = 0,
    @servChargeAfterDiscount BIT = 0,
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
            outletId,
            outletName,
            outletCode,
            deptId,
            channelId,
            phoneNo,
            emailId,
            billPrefix,
            defaultPayModeId,
            address,
            taxAfterDiscount,
            servChargeAfterDiscount,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_outlet
    END

        ELSE IF @flag = 'GETBYID'
        BEGIN
        SELECT
            outletId,
            outletName,
            outletCode,
            deptId,
            channelId,
            phoneNo,
            emailId,
            billPrefix,
            defaultPayModeId,
            address,
            taxAfterDiscount,
            servChargeAfterDiscount,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_outlet
        WHERE outletId = @outletId
            AND isActive = 1
    END

        ELSE IF @flag = 'INSERT'
        BEGIN
        INSERT INTO m_outlet
            (
            outletId,
            outletName,
            outletCode,
            deptId,
            channelId,
            phoneNo,
            emailId,
            billPrefix,
            defaultPayModeId,
            address,
            taxAfterDiscount,
            servChargeAfterDiscount,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
            )
        VALUES
            (
                NEWID(),
                @outletName,
                @outletCode,
                @deptId,
                @channelId,
                @phoneNo,
                @emailId,
                @billPrefix,
                @defaultPayModeId,
                @address,
                @taxAfterDiscount,
                @servChargeAfterDiscount,
                GETDATE(),
                @loggedUser,
                GETDATE(),
                @loggedUser,
                @isActive
            )
    END

        ELSE IF @flag = 'UPDATE'
        BEGIN
        IF @outletId IS NULL
            BEGIN
            RAISERROR('OutletId is required for UPDATE',16,1)
            RETURN
        END

        UPDATE m_outlet
            SET
                outletName = @outletName,
                outletCode = @outletCode,
                deptId = @deptId,
                channelId = @channelId,
                phoneNo = @phoneNo,
                emailId = @emailId,
                billPrefix = @billPrefix,
                defaultPayModeId = @defaultPayModeId,
                address = @address,
                taxAfterDiscount = @taxAfterDiscount,
                servChargeAfterDiscount = @servChargeAfterDiscount,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser
            WHERE outletId = @outletId
    END

        ELSE IF @flag = 'DELETE'
        BEGIN
        IF @outletId IS NULL
            BEGIN
            RAISERROR('OutletId is required for DELETE',16,1)
            RETURN
        END

        UPDATE m_outlet
            SET
                isActive = 0,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser
            WHERE outletId = @outletId
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
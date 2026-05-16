CREATE PROCEDURE [dbo].[sp_company]
    (
    @flag VARCHAR(50),
    @companyId UNIQUEIDENTIFIER = NULL,
    @companyName NVARCHAR(200) = NULL,
    @address NVARCHAR(200) = NULL,
    @stateId UNIQUEIDENTIFIER = NULL,
    @phoneNo NVARCHAR(50) = NULL,
    @emailId NVARCHAR(50) = NULL,
    @GSTNo NVARCHAR(50) = NULL,
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
            companyId,
            companyName,
            address,
            stateId,
            phoneNo,
            emailId,
            GSTNo,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_company
    END

        ELSE IF @flag = 'GETBYID'
        BEGIN
        SELECT
            companyId,
            companyName,
            address,
            stateId,
            phoneNo,
            emailId,
            GSTNo,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_company
        WHERE companyId = @companyId
    END

        ELSE IF @flag = 'INSERT'
        BEGIN
        -- Duplicate check (based on company name + GST)
        IF EXISTS (
                SELECT 1
        FROM m_company
        WHERE companyName = @companyName
            AND GSTNo = @GSTNo
            )
            BEGIN
            SELECT 'Company already exists' AS message
            RETURN
        END

        INSERT INTO m_company
            (
            companyId,
            companyName,
            address,
            stateId,
            phoneNo,
            emailId,
            GSTNo,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
            )
        VALUES
            (
                NEWID(),
                @companyName,
                @address,
                @stateId,
                @phoneNo,
                @emailId,
                @GSTNo,
                GETDATE(),
                @loggedUser,
                GETDATE(),
                @loggedUser,
                @isActive
            )
    END

        ELSE IF @flag = 'UPDATE'
        BEGIN
        -- Duplicate check excluding current record
        IF EXISTS (
                SELECT 1
        FROM m_company
        WHERE companyName = @companyName
            AND GSTNo = @GSTNo
            AND companyId <> @companyId
            )
            BEGIN
            SELECT 'Company already exists' AS message
            RETURN
        END

        UPDATE m_company
            SET
                companyName = @companyName,
                address = @address,
                stateId = @stateId,
                phoneNo = @phoneNo,
                emailId = @emailId,
                GSTNo = @GSTNo,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser,
                isActive = @isActive
            WHERE companyId = @companyId
    END

        ELSE IF @flag = 'DELETE'
        BEGIN
        UPDATE m_company
            SET
                isActive = 0,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser
            WHERE companyId = @companyId
    END

    END TRY

    BEGIN CATCH
        SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage
    END CATCH

END
GO
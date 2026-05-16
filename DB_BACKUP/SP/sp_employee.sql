CREATE PROCEDURE [dbo].[sp_employee]
    (
    @flag VARCHAR(50),
    @employeeID UNIQUEIDENTIFIER = NULL,
    @channelID CHAR(36) = NULL,
    @name NVARCHAR(255) = NULL,
    @email NVARCHAR(255) = NULL,
    @password NVARCHAR(255) = NULL,
    @mobile NVARCHAR(255) = NULL,
    @joiningDate DATETIMEOFFSET(7) = NULL,
    @resignDate DATETIMEOFFSET(7) = NULL,
    @deptId CHAR(36) = NULL,
    @empTypeId CHAR(36) = NULL,
    @empCode NVARCHAR(255) = NULL,
    @designation NVARCHAR(255) = NULL,
    @imageAddress NVARCHAR(255) = NULL,
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
            employeeID,
            channelID,
            name,
            email,
            mobile,
            joiningDate,
            resignDate,
            deptId,
            empTypeId,
            empCode,
            designation,
            imageAddress,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_employee
    END

        ELSE IF @flag = 'GETBYID'
        BEGIN
        SELECT
            employeeID,
            channelID,
            name,
            email,
            mobile,
            joiningDate,
            resignDate,
            deptId,
            empTypeId,
            empCode,
            designation,
            imageAddress,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
        FROM m_employee
        WHERE employeeID = @employeeID
    END

        ELSE IF @flag = 'INSERT'
        BEGIN
        -- Duplicate check (Email OR Employee Code)
        IF EXISTS (
                SELECT 1
        FROM m_employee
        WHERE (email = @email OR empCode = @empCode)
            AND channelID = @channelID
            )
            BEGIN
            SELECT 'Employee already exists (Email or Code)' AS message
            RETURN
        END

        INSERT INTO m_employee
            (
            employeeID,
            channelID,
            name,
            email,
            password,
            mobile,
            joiningDate,
            resignDate,
            deptId,
            empTypeId,
            empCode,
            designation,
            imageAddress,
            createdDate,
            createdBy,
            modifiedDate,
            modifiedBy,
            isActive
            )
        VALUES
            (
                NEWID(),
                @channelID,
                @name,
                @email,
                @password,
                @mobile,
                @joiningDate,
                @resignDate,
                @deptId,
                @empTypeId,
                @empCode,
                @designation,
                @imageAddress,
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
        FROM m_employee
        WHERE (email = @email OR empCode = @empCode)
            AND channelID = @channelID
            AND employeeID <> @employeeID
            )
            BEGIN
            SELECT 'Employee already exists (Email or Code)' AS message
            RETURN
        END

        UPDATE m_employee
            SET
                channelID = @channelID,
                name = @name,
                email = @email,
                password = @password,
                mobile = @mobile,
                joiningDate = @joiningDate,
                resignDate = @resignDate,
                deptId = @deptId,
                empTypeId = @empTypeId,
                empCode = @empCode,
                designation = @designation,
                imageAddress = @imageAddress,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser,
                isActive = @isActive
            WHERE employeeID = @employeeID
    END

        ELSE IF @flag = 'DELETE'
        BEGIN
        UPDATE m_employee
            SET
                isActive = 0,
                modifiedDate = GETDATE(),
                modifiedBy = @loggedUser
            WHERE employeeID = @employeeID
    END

    END TRY

    BEGIN CATCH
        SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage
    END CATCH

END
GO
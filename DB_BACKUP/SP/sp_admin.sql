CREATE   PROCEDURE [dbo].[sp_admin]
    (
    @flag NVARCHAR(50),
    @adminId UNIQUEIDENTIFIER = NULL,
    @adminName NVARCHAR(50) = NULL,
    @email NVARCHAR(100) = NULL,
    @mobile NVARCHAR(15) = NULL,
    @passwordHash NVARCHAR(255) = NULL,
    @securityQuestion NVARCHAR(255) = NULL,
    @securityAnswer NVARCHAR(255) = NULL,
    @isActive BIT = 1
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

    IF @flag = 'INSERT'
    BEGIN
        INSERT INTO admin
            (
            adminId,
            adminName,
            email,
            mobile,
            [password],
            securityQuestion,
            securityAnswer,
            createdDate,
            modifiedDate,
            isActive
            )
        VALUES
            (
                NEWID(),
                @adminName,
                @email,
                @mobile,
                @passwordHash,
                @securityQuestion,
                @securityAnswer,
                GETDATE(),
                GETDATE(),
                @isActive
        )
    END

    ELSE IF @flag = 'UPDATE'
    BEGIN
        IF @adminId IS NULL
        BEGIN
            RAISERROR('AdminId is required for UPDATE',16,1)
            RETURN
        END

        UPDATE admin
        SET
            adminName = @adminName,
            email = @email,
            mobile = @mobile,
            [password] = @passwordHash,
            securityQuestion = @securityQuestion,
            securityAnswer = @securityAnswer,
            modifiedDate = GETDATE(),
            isActive = @isActive
        WHERE adminId = @adminId
    END

    ELSE IF @flag = 'DELETE'
    BEGIN
        IF @adminId IS NULL
        BEGIN
            RAISERROR('AdminId is required for DELETE',16,1)
            RETURN
        END

        UPDATE admin
        SET
            isActive = 0,
            modifiedDate = GETDATE()
        WHERE adminId = @adminId
    END

    ELSE IF @flag = 'SELECT'
    BEGIN
        SELECT
            adminId,
            adminName,
            email,
            mobile,
            securityQuestion,
            createdDate,
            modifiedDate,
            isActive
        FROM admin
        ORDER BY createdDate DESC
    END

    ELSE IF @flag = 'SELECTBYEMAIL'
    BEGIN
        SELECT TOP 1
            adminId,
            adminName,
            email,
            mobile,
            [password],
            securityQuestion,
            securityAnswer,
            isActive
        FROM admin
        WHERE email = @email
            AND isActive = 1
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
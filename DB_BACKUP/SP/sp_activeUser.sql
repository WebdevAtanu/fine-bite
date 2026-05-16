CREATE PROCEDURE [dbo].[sp_activeUser]
    (
    @Flag NVARCHAR(50),
    @UserID UNIQUEIDENTIFIER = NULL,
    @accessToken NVARCHAR(255) = NULL,
    @RefreshToken NVARCHAR(255) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

    IF @Flag = 'INSERTACTIVEUSER'
    BEGIN

        IF @UserID IS NULL
        BEGIN
            RAISERROR('UserID is required',16,1)
            RETURN
        END

        IF EXISTS (SELECT 1
        FROM activeUser
        WHERE UserID = @UserID)
        BEGIN
            UPDATE activeUser
            SET
                accessToken = @accessToken,
                RefreshToken = @RefreshToken,
                loginAt = GETDATE()
            WHERE UserID = @UserID
        END
        ELSE
        BEGIN
            INSERT INTO activeUser
                (
                UserID,
                accessToken,
                RefreshToken,
                loginAt
                )
            VALUES
                (
                    @UserID,
                    @accessToken,
                    @RefreshToken,
                    GETDATE()
            )
        END

    END

    ELSE IF @Flag = 'GETACTIVEUSERBYUSERID'
    BEGIN

        IF @UserID IS NULL
        BEGIN
            RAISERROR('UserID is required',16,1)
            RETURN
        END

        SELECT TOP 1
            UserID,
            accessToken,
            RefreshToken,
            loginAt
        FROM activeUser
        WHERE UserID = @UserID
        ORDER BY loginAt DESC

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
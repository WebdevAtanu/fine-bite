select * from orderHeader
select * from orderDetails

GO
CREATE PROCEDURE usp_order
    @Flag VARCHAR(20),
    @OutletId UNIQUEIDENTIFIER,
    @TableId UNIQUEIDENTIFIER,
    @OrderDate DATETIME,
    @OrderRemarks VARCHAR(255),
    @CustomerId UNIQUEIDENTIFIER,
    @IsVip BIT,
    @OrderDetails dbo.OrderDetailsType READONLY

AS
BEGIN
    SELECT *
    from admin
END

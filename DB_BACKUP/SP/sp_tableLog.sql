CREATE PROCEDURE [dbo].[sp_tableLog]
    (
    @flag NVARCHAR(50),
    @outletId UNIQUEIDENTIFIER
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    DECLARE @channelId UNIQUEIDENTIFIER
    SELECT @channelId = channelId
    from m_outlet
    where outletId = @outletId
        IF @flag = 'GETALL'
        BEGIN

        with
            facilityStatus
            as

            (
                select facilityStatusId, statusName, prefix, color
                from m_facilityStatus
                WHERE channelId = @channelId and isActive = 1 and [type]='table' and prefix = 'V'
            )

                    select
                mt.tableName,
                mt.tableId,
                mt.sectionId,
                sc.sectionName,
                mt.capacity,
                mt.addonCapacity,
                mt.serial,

                --log data
                '' as invoiceNumber,
                0 as pax,
                'master' as tableType,
                null as customerId,
                '' as customerName,
                fs.facilityStatusId,
                fs.statusName,
                fs.prefix as tablePrefix,
                fs.color,
                0 as isOpenTable,
                0 as isVIP,
                '' as prefix,
                0 as subTotal,
                0 as netAmount,
                '' as remarks
            from m_table mt
                INNER JOIN m_section sc on mt.sectionId = sc.sectionId
                CROSS JOIN facilityStatus fs
            where mt.outletId = @outletId and mt.isActive=1
                AND NOT EXISTS (
        SELECT 1
                FROM map_tableLog mtl
                WHERE mtl.tableId = mt.tableId
                    AND mtl.outletId = @outletId
                    AND mtl.isActive = 1
    )

        UNION

            select
                mtl.tableName,
                mtl.tableId,
                mtl.sectionId,
                sc.sectionName,
                mtl.capacity,
                0 as addonCapacity,
                mtl.serial,

                --log data
                mtl.invoiceNumber,
                mtl.pax,
                mtl.tableType,
                mtl.customerId,
                cr.customerName,
                mtl.facilityStatusId,
                fs.statusName,
                fs.prefix,
                fs.color,
                mtl.isOpenTable,
                mtl.isVIP,
                mtl.prefix as tablePrefix,
                mtl.subTotal,
                mtl.netAmount,
                mtl.remarks

            from map_tableLog mtl
                INNER JOIN m_section sc on mtl.sectionId = sc.sectionId
                LEFT JOIN m_customer cr on mtl.customerId = cr.customerId
                LEFT JOIN m_facilityStatus fs on mtl.facilityStatusId = fs.facilityStatusId
            where mtl.outletId = @outletId and mtl.isActive=1
    END
    
END TRY
BEGIN CATCH
SELECT ERROR_NUMBER(),
        ERROR_LINE(),
        ERROR_MESSAGE()
END CATCH
--EXECUTE sp_tableLog 'GETALL', 'AA7A3A5E-C61E-4A13-BBA8-3E33718D06E6'
END
GO
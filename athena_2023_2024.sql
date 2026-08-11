SELECT
year(np.connote__created_at)tahun,
month(np.connote__created_at) bulan,
np.customer_code ,
np.location_data_created__custom_field__nokprk ,
COUNT(connote__connote_code) AS produksi,
SUM(
COALESCE(connote__connote_service_price, 0) / 1.011
+ COALESCE(connote__connote_surcharge_amount, 0) / 1.11
)+
SUM(COALESCE(np.custom_field__fee_value, 0)
) pendapatan_final,
sum(coalesce(np.connote__chargeable_weight,0))connote__chargeable_weight
FROM silver.nipos__nipos np
WHERE
UPPER(connote__location_name) != 'AGP TESTING LOCATION'
AND connote__connote_amount >= 0
AND connote__connote_service != 'LNINCOMING'
AND UPPER(connote__connote_state) NOT IN ('CANCEL', 'PENDING')
AND np.connote__created_at >date '2023-01-01'
and np.connote__created_at <date '2025-01-01'
and np.connote__connote_service not in ('KRT', 'KBM', 'FFE', 'FF-LKPP')
GROUP BY 1,2,3,4
order by 1,2,3,4

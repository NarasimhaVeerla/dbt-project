SELECT C.Customer_id,
  C.Customer_name,
  C.City,C.Order_id,
  O.Item_name,
  I.Price,
  O.Quantity
FROM `big-query-project-438917.dbt_nveerala.customer` AS C
JOIN `big-query-project-438917.dbt_nveerala.orders` AS O ON C.Order_id = O.Order_id
JOIN `big-query-project-438917.dbt_nveerala.items_list` I ON O.Item_name = I.Item_name
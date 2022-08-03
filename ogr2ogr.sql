SELECT 
  trees.gml_id AS trees_gml_id,
  trees. "baumid" AS trees_baumid,
  trees. "standortnr" AS trees_standortnr,
  trees. "kennzeich" AS trees_kennzeich,
  trees. "namenr" AS trees_namenr,
  trees. "art_dtsch" AS trees_art_dtsch,
  trees. "art_bot" AS trees_art_bot,
  trees. "gattung_deutsch" AS trees_gattung_deutsch,
  trees. "gattung" AS trees_gattung,
  trees. "strname" AS trees_strname,
  trees. "hausnr" AS trees_hausnr,
  trees. "pflanzjahr" AS trees_pflanzjahr,
  trees. "standalter" AS trees_standalter,
  trees. "stammumfg" AS trees_stammumfg,
  trees. "baumhoehe" AS trees_baumhoehe,
  trees. "bezirk" AS trees_bezirk,
  trees. "eigentuemer" AS trees_eigentuemer,
  trees. "zusatz" AS trees_zusatz,
  trees. "kronedurch" AS trees_kronedurch,
  trees. "geometry" AS trees_geometry,
  trees. "lat" AS trees_lat,
  trees. "lng" AS trees_lng,
  trees. "created_at" AS trees_created_at,
  trees. "updated_at" AS trees_updated_at,
  _nowcast. "baum_id" AS nowcast_baum_id,
  /*
  _nowcast. "nowcast_types_id_array" AS nowcast_type_ids, 
  _nowcast. "nowcast_timestamp_array" AS nowcast_timestamps,
  _nowcast. "nowcast_values_array" AS nowcast_values,
  _nowcast. "nowcast_created_at_array" AS nowcast_created_ats,
  _nowcast. "nowcast_model_id_array" AS nowcast_model_ids,
  */
  
  _nowcast. "nowcast_type_1" AS nowcast_type_1,
  _nowcast. "nowcast_type_2" AS nowcast_type_2,
  _nowcast. "nowcast_type_3" AS nowcast_type_3,
  _nowcast. "nowcast_type_4" AS nowcast_type_4,   

  _nowcast. "nowcast_timestamp_1" AS nowcast_timestamp_1,
  _nowcast. "nowcast_timestamp_2" AS nowcast_timestamp_2,
  _nowcast. "nowcast_timestamp_3" AS nowcast_timestamp_3,
  _nowcast. "nowcast_timestamp_4" AS nowcast_timestamp_4,

  _nowcast. "nowcast_values_1" AS nowcast_values_1,
  _nowcast. "nowcast_values_2" AS nowcast_values_2,
  _nowcast. "nowcast_values_3" AS nowcast_values_3,
  _nowcast. "nowcast_values_4" AS nowcast_values_4,  
  
  _nowcast. "nowcast_created_at_1" AS nowcast_created_at_1,
  _nowcast. "nowcast_created_at_2" AS nowcast_created_at_2,
  _nowcast. "nowcast_created_at_3" AS nowcast_created_at_3,
  _nowcast. "nowcast_created_at_4" AS nowcast_created_at_4,
 
  _nowcast. "nowcast_model_id_1" AS nowcast_model_id_1,
  _nowcast. "nowcast_model_id_2" AS nowcast_model_id_2,
  _nowcast. "nowcast_model_id_3" AS nowcast_model_id_3,
  _nowcast. "nowcast_model_id_4" AS nowcast_model_id_4
  

  
FROM
  api.trees
  LEFT JOIN (
    SELECT
      nowcast_baum_id AS baum_id,
      ARRAY_AGG(DISTINCT distinct_nowcast.forcast_type ORDER BY distinct_nowcast.forcast_type) AS nowcast_types_array,
	  /*
	  ARRAY_AGG(forecast_types_id) AS nowcast_types_id_array,
	  ARRAY_AGG(distinct_nowcast.nowcast_value) AS nowcast_values_array,
	  ARRAY_AGG(nowcast_created_at) AS nowcast_created_at_array,
	  ARRAY_AGG(nowcast_model_id) AS nowcast_model_id_array,
	  ARRAY_AGG(nowcast_timestamp) AS nowcast_timestamp_array
	  */
	  (ARRAY_AGG(forecast_types_id)) [1] nowcast_type_1,
	  (ARRAY_AGG(forecast_types_id)) [2] nowcast_type_2,
	  (ARRAY_AGG(forecast_types_id)) [3] nowcast_type_3,
	  (ARRAY_AGG(forecast_types_id)) [4] nowcast_type_4,
	  
	  (ARRAY_AGG(distinct_nowcast.nowcast_value)) [1] nowcast_values_1,
	  (ARRAY_AGG(distinct_nowcast.nowcast_value)) [2] nowcast_values_2,	  
	  (ARRAY_AGG(distinct_nowcast.nowcast_value)) [3] nowcast_values_3,	  
	  (ARRAY_AGG(distinct_nowcast.nowcast_value)) [4] nowcast_values_4,
	  
	  (ARRAY_AGG(nowcast_model_id)) [1] nowcast_model_id_1,
	  (ARRAY_AGG(nowcast_model_id)) [2] nowcast_model_id_2,
	  (ARRAY_AGG(nowcast_model_id)) [3] nowcast_model_id_3,
	  (ARRAY_AGG(nowcast_model_id)) [4] nowcast_model_id_4,
	  
	  (ARRAY_AGG(nowcast_created_at)) [1] nowcast_created_at_1,
	  (ARRAY_AGG(nowcast_created_at)) [2] nowcast_created_at_2,
	  (ARRAY_AGG(nowcast_created_at)) [3] nowcast_created_at_3,
	  (ARRAY_AGG(nowcast_created_at)) [4] nowcast_created_at_4,
	  
	  (ARRAY_AGG(nowcast_timestamp)) [1] nowcast_timestamp_1,
	  (ARRAY_AGG(nowcast_timestamp)) [2] nowcast_timestamp_2,
	  (ARRAY_AGG(nowcast_timestamp)) [3] nowcast_timestamp_3,
	  (ARRAY_AGG(nowcast_timestamp)) [4] nowcast_timestamp_4

    FROM ( SELECT DISTINCT ON (n.baum_id, f. "name")
        n.id AS nowcast_id,
        n. "timestamp" AS nowcast_timestamp,
        n.baum_id AS nowcast_baum_id,
        n. "value" AS nowcast_value,
        n.created_at AS nowcast_created_at,
        n.model_id AS nowcast_model_id,
        f. "name" AS forcast_type,
        f.id AS forecast_types_id
      FROM
        api.nowcast n
        JOIN api.forecast_types f ON n.type_id = f.id
      ORDER BY
        n.baum_id,
        f. "name",
        n. "timestamp" DESC) distinct_nowcast
    GROUP BY
      nowcast_baum_id) AS _nowcast ON trees.gml_id = _nowcast.baum_id

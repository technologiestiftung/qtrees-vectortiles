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
  _nowcast. "id" AS nowcast_id,
  _nowcast. "baum_id" AS nowcast_baum_id,
  _nowcast. "type_id" AS nowcast_type_id,
  _nowcast. "timestamp" AS nowcast_timestamp,
  _nowcast. "value" AS nowcast_value,
  _nowcast. "created_at" AS nowcast_created_at,
  _nowcast. "model_id" AS nowcast_model_id
FROM
  api.trees
  LEFT JOIN ( SELECT DISTINCT ON (n.baum_id)
      n.baum_id,
      n.id,
      type_id,
      "timestamp",
      value,
      created_at,
      model_id
    FROM
      api.nowcast AS n
    ORDER BY
      n.baum_id,
      "timestamp" DESC) AS _nowcast ON trees.gml_id = _nowcast.baum_id

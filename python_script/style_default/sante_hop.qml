<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="AllStyleCategories" hasScaleBasedVisibilityFlag="0" simplifyLocal="1" simplifyAlgorithm="0" version="3.4.7-Madeira" maxScale="0" readOnly="0" minScale="1e+08" simplifyDrawingHints="1" simplifyDrawingTol="1" simplifyMaxScale="1" labelsEnabled="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 forceraster="0" symbollevels="0" enableorderby="0" type="singleSymbol">
    <symbols>
      <symbol force_rhr="0" name="0" alpha="1" type="marker" clip_to_extent="1">
        <layer locked="0" pass="0" enabled="1" class="SimpleMarker">
          <prop v="0" k="angle"/>
          <prop v="17,220,61,255" k="color"/>
          <prop v="1" k="horizontal_anchor_point"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="circle" k="name"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="35,35,35,255" k="outline_color"/>
          <prop v="solid" k="outline_style"/>
          <prop v="0" k="outline_width"/>
          <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
          <prop v="MM" k="outline_width_unit"/>
          <prop v="diameter" k="scale_method"/>
          <prop v="2" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vertical_anchor_point"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" value="" type="QString"/>
              <Option name="properties"/>
              <Option name="type" value="collection" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
    <rotation/>
    <sizescale/>
  </renderer-v2>
  <customproperties/>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <layerOpacity>1</layerOpacity>
  <geometryOptions geometryPrecision="0" removeDuplicateNodes="0">
    <activeChecks type="StringList">
      <Option value="" type="QString"/>
    </activeChecks>
    <checkConfiguration/>
  </geometryOptions>
  <fieldConfiguration>
    <field name="fid">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="osm_id">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="name">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="amenity">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="hstore_to_json">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" index="0" field="fid"/>
    <alias name="" index="1" field="osm_id"/>
    <alias name="" index="2" field="name"/>
    <alias name="" index="3" field="amenity"/>
    <alias name="" index="4" field="hstore_to_json"/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default expression="" applyOnUpdate="0" field="fid"/>
    <default expression="" applyOnUpdate="0" field="osm_id"/>
    <default expression="" applyOnUpdate="0" field="name"/>
    <default expression="" applyOnUpdate="0" field="amenity"/>
    <default expression="" applyOnUpdate="0" field="hstore_to_json"/>
  </defaults>
  <constraints>
    <constraint unique_strength="1" notnull_strength="1" exp_strength="0" constraints="3" field="fid"/>
    <constraint unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0" field="osm_id"/>
    <constraint unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0" field="name"/>
    <constraint unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0" field="amenity"/>
    <constraint unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0" field="hstore_to_json"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" desc="" field="fid"/>
    <constraint exp="" desc="" field="osm_id"/>
    <constraint exp="" desc="" field="name"/>
    <constraint exp="" desc="" field="amenity"/>
    <constraint exp="" desc="" field="hstore_to_json"/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions/>
  <attributetableconfig actionWidgetStyle="dropDown" sortOrder="0" sortExpression="">
    <columns/>
  </attributetableconfig>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable/>
  <labelOnTop/>
  <widgets/>
  <previewExpression></previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>0</layerGeometryType>
</qgis>

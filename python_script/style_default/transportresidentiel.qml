<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis simplifyLocal="1" simplifyAlgorithm="0" styleCategories="AllStyleCategories" simplifyMaxScale="1" hasScaleBasedVisibilityFlag="0" simplifyDrawingTol="1" maxScale="0" labelsEnabled="0" version="3.14.1-Pi" minScale="100000000" simplifyDrawingHints="1" readOnly="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal endExpression="" durationField="" startExpression="" fixedDuration="0" durationUnit="min" accumulate="0" enabled="0" mode="0" endField="" startField="">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 symbollevels="0" forceraster="0" enableorderby="0" type="singleSymbol">
    <symbols>
      <symbol clip_to_extent="1" name="0" type="line" alpha="1" force_rhr="0">
        <layer pass="0" enabled="1" locked="0" class="SimpleLine">
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="251,198,198,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.4"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="use_custom_dash" v="0"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
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
  <geometryOptions removeDuplicateNodes="0" geometryPrecision="0">
    <activeChecks type="StringList">
      <Option value="" type="QString"/>
    </activeChecks>
    <checkConfiguration/>
  </geometryOptions>
  <referencedLayers/>
  <referencingLayers/>
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
    <alias field="fid" index="0" name=""/>
    <alias field="osm_id" index="1" name=""/>
    <alias field="name" index="2" name=""/>
    <alias field="amenity" index="3" name=""/>
    <alias field="hstore_to_json" index="4" name=""/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default expression="" field="fid" applyOnUpdate="0"/>
    <default expression="" field="osm_id" applyOnUpdate="0"/>
    <default expression="" field="name" applyOnUpdate="0"/>
    <default expression="" field="amenity" applyOnUpdate="0"/>
    <default expression="" field="hstore_to_json" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint unique_strength="1" exp_strength="0" notnull_strength="1" field="fid" constraints="3"/>
    <constraint unique_strength="0" exp_strength="0" notnull_strength="0" field="osm_id" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" notnull_strength="0" field="name" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" notnull_strength="0" field="amenity" constraints="0"/>
    <constraint unique_strength="0" exp_strength="0" notnull_strength="0" field="hstore_to_json" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="fid" exp=""/>
    <constraint desc="" field="osm_id" exp=""/>
    <constraint desc="" field="name" exp=""/>
    <constraint desc="" field="amenity" exp=""/>
    <constraint desc="" field="hstore_to_json" exp=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction value="{00000000-0000-0000-0000-000000000000}" key="Canvas"/>
  </attributeactions>
  <attributetableconfig sortOrder="0" sortExpression="" actionWidgetStyle="dropDown">
    <columns/>
  </attributetableconfig>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <storedexpressions/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <editable/>
  <labelOnTop/>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression></previewExpression>
  <mapTip></mapTip>
  <layerGeometryType>1</layerGeometryType>
</qgis>

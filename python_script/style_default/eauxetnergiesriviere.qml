<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis simplifyMaxScale="1" version="3.14.1-Pi" simplifyLocal="1" styleCategories="AllStyleCategories" simplifyAlgorithm="0" minScale="100000000" labelsEnabled="0" simplifyDrawingHints="1" simplifyDrawingTol="1" readOnly="0" maxScale="0" hasScaleBasedVisibilityFlag="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal enabled="0" startField="" mode="0" startExpression="" durationField="" fixedDuration="0" durationUnit="min" endField="" endExpression="" accumulate="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 enableorderby="0" symbollevels="0" type="singleSymbol" forceraster="0">
    <symbols>
      <symbol name="0" alpha="1" type="line" clip_to_extent="1" force_rhr="0">
        <layer pass="0" enabled="1" locked="0" class="SimpleLine">
          <prop v="square" k="capstyle"/>
          <prop v="5;2" k="customdash"/>
          <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
          <prop v="MM" k="customdash_unit"/>
          <prop v="0" k="draw_inside_polygon"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="31,120,180,255" k="line_color"/>
          <prop v="solid" k="line_style"/>
          <prop v="0.4" k="line_width"/>
          <prop v="MM" k="line_width_unit"/>
          <prop v="0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="0" k="ring_filter"/>
          <prop v="0" k="use_custom_dash"/>
          <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
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
      <Option type="QString" value=""/>
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
    <alias field="fid" name="" index="0"/>
    <alias field="osm_id" name="" index="1"/>
    <alias field="name" name="" index="2"/>
    <alias field="amenity" name="" index="3"/>
    <alias field="hstore_to_json" name="" index="4"/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default field="fid" expression="" applyOnUpdate="0"/>
    <default field="osm_id" expression="" applyOnUpdate="0"/>
    <default field="name" expression="" applyOnUpdate="0"/>
    <default field="amenity" expression="" applyOnUpdate="0"/>
    <default field="hstore_to_json" expression="" applyOnUpdate="0"/>
  </defaults>
  <constraints>
    <constraint field="fid" exp_strength="0" constraints="3" notnull_strength="1" unique_strength="1"/>
    <constraint field="osm_id" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="name" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="amenity" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
    <constraint field="hstore_to_json" exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="fid" exp="" desc=""/>
    <constraint field="osm_id" exp="" desc=""/>
    <constraint field="name" exp="" desc=""/>
    <constraint field="amenity" exp="" desc=""/>
    <constraint field="hstore_to_json" exp="" desc=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction key="Canvas" value="{00000000-0000-0000-0000-000000000000}"/>
  </attributeactions>
  <attributetableconfig actionWidgetStyle="dropDown" sortOrder="0" sortExpression="">
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

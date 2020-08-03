<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis readOnly="0" minScale="100000000" simplifyAlgorithm="0" simplifyMaxScale="1" maxScale="0" hasScaleBasedVisibilityFlag="0" styleCategories="AllStyleCategories" simplifyDrawingHints="1" simplifyDrawingTol="1" simplifyLocal="1" version="3.14.1-Pi" labelsEnabled="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal durationUnit="min" durationField="" fixedDuration="0" startField="" mode="0" endExpression="" endField="" startExpression="" enabled="0" accumulate="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <renderer-v2 enableorderby="0" type="singleSymbol" forceraster="0" symbollevels="0">
    <symbols>
      <symbol clip_to_extent="1" type="fill" force_rhr="0" alpha="1" name="0">
        <layer class="SimpleFill" locked="0" pass="0" enabled="1">
          <prop v="3x:0,0,0,0,0,0" k="border_width_map_unit_scale"/>
          <prop v="133,182,111,255" k="color"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="51,160,44,255" k="outline_color"/>
          <prop v="solid" k="outline_style"/>
          <prop v="0.5" k="outline_width"/>
          <prop v="MM" k="outline_width_unit"/>
          <prop v="solid" k="style"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" name="name" value=""/>
              <Option name="properties"/>
              <Option type="QString" name="type" value="collection"/>
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
    <constraint exp_strength="0" field="fid" constraints="3" unique_strength="1" notnull_strength="1"/>
    <constraint exp_strength="0" field="osm_id" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="name" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="amenity" constraints="0" unique_strength="0" notnull_strength="0"/>
    <constraint exp_strength="0" field="hstore_to_json" constraints="0" unique_strength="0" notnull_strength="0"/>
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
    <defaultAction value="{00000000-0000-0000-0000-000000000000}" key="Canvas"/>
  </attributeactions>
  <attributetableconfig actionWidgetStyle="dropDown" sortExpression="" sortOrder="0">
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
  <layerGeometryType>2</layerGeometryType>
</qgis>

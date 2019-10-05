<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.4.7-Madeira" hasScaleBasedVisibilityFlag="0" simplifyLocal="1" minScale="1e+08" styleCategories="AllStyleCategories" simplifyMaxScale="1" labelsEnabled="0" readOnly="0" maxScale="0" simplifyDrawingTol="1" simplifyAlgorithm="0" simplifyDrawingHints="1">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 type="singleSymbol" symbollevels="0" forceraster="0" enableorderby="0">
    <symbols>
      <symbol name="0" clip_to_extent="1" force_rhr="0" alpha="1" type="marker">
        <layer enabled="1" pass="0" locked="0" class="SimpleMarker">
          <prop k="angle" v="0"/>
          <prop k="color" v="62,123,198,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="2"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
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
  <geometryOptions removeDuplicateNodes="0" geometryPrecision="0">
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
    <constraint field="fid" constraints="3" notnull_strength="1" unique_strength="1" exp_strength="0"/>
    <constraint field="osm_id" constraints="0" notnull_strength="0" unique_strength="0" exp_strength="0"/>
    <constraint field="name" constraints="0" notnull_strength="0" unique_strength="0" exp_strength="0"/>
    <constraint field="amenity" constraints="0" notnull_strength="0" unique_strength="0" exp_strength="0"/>
    <constraint field="hstore_to_json" constraints="0" notnull_strength="0" unique_strength="0" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="fid" desc="" exp=""/>
    <constraint field="osm_id" desc="" exp=""/>
    <constraint field="name" desc="" exp=""/>
    <constraint field="amenity" desc="" exp=""/>
    <constraint field="hstore_to_json" desc="" exp=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions/>
  <attributetableconfig sortExpression="" sortOrder="0" actionWidgetStyle="dropDown">
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

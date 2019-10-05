<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis simplifyMaxScale="1" maxScale="0" simplifyDrawingHints="1" minScale="1e+08" hasScaleBasedVisibilityFlag="0" readOnly="0" version="3.4.7-Madeira" simplifyAlgorithm="0" styleCategories="AllStyleCategories" simplifyDrawingTol="1" labelsEnabled="0" simplifyLocal="1">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 symbollevels="0" forceraster="0" enableorderby="0" type="singleSymbol">
    <symbols>
      <symbol alpha="1" clip_to_extent="1" name="0" force_rhr="0" type="line">
        <layer enabled="1" locked="0" class="SimpleLine" pass="0">
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="87,214,113,255"/>
          <prop k="line_style" v="solid"/>
          <prop k="line_width" v="0.26"/>
          <prop k="line_width_unit" v="MM"/>
          <prop k="offset" v="0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="ring_filter" v="0"/>
          <prop k="use_custom_dash" v="0"/>
          <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
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
    <field name="highway">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="bridge">
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
    <field name="oneway">
      <editWidget type="">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="junction">
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
    <alias field="highway" index="2" name=""/>
    <alias field="bridge" index="3" name=""/>
    <alias field="name" index="4" name=""/>
    <alias field="oneway" index="5" name=""/>
    <alias field="junction" index="6" name=""/>
    <alias field="amenity" index="7" name=""/>
    <alias field="hstore_to_json" index="8" name=""/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default field="fid" applyOnUpdate="0" expression=""/>
    <default field="osm_id" applyOnUpdate="0" expression=""/>
    <default field="highway" applyOnUpdate="0" expression=""/>
    <default field="bridge" applyOnUpdate="0" expression=""/>
    <default field="name" applyOnUpdate="0" expression=""/>
    <default field="oneway" applyOnUpdate="0" expression=""/>
    <default field="junction" applyOnUpdate="0" expression=""/>
    <default field="amenity" applyOnUpdate="0" expression=""/>
    <default field="hstore_to_json" applyOnUpdate="0" expression=""/>
  </defaults>
  <constraints>
    <constraint field="fid" unique_strength="1" notnull_strength="1" exp_strength="0" constraints="3"/>
    <constraint field="osm_id" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="highway" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="bridge" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="name" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="oneway" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="junction" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="amenity" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
    <constraint field="hstore_to_json" unique_strength="0" notnull_strength="0" exp_strength="0" constraints="0"/>
  </constraints>
  <constraintExpressions>
    <constraint field="fid" desc="" exp=""/>
    <constraint field="osm_id" desc="" exp=""/>
    <constraint field="highway" desc="" exp=""/>
    <constraint field="bridge" desc="" exp=""/>
    <constraint field="name" desc="" exp=""/>
    <constraint field="oneway" desc="" exp=""/>
    <constraint field="junction" desc="" exp=""/>
    <constraint field="amenity" desc="" exp=""/>
    <constraint field="hstore_to_json" desc="" exp=""/>
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
  <layerGeometryType>1</layerGeometryType>
</qgis>

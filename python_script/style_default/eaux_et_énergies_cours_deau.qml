<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis maxScale="0" labelsEnabled="0" simplifyMaxScale="1" readOnly="0" version="3.4.7-Madeira" simplifyDrawingTol="1" minScale="1e+08" simplifyAlgorithm="0" styleCategories="AllStyleCategories" hasScaleBasedVisibilityFlag="0" simplifyDrawingHints="1" simplifyLocal="1">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <renderer-v2 symbollevels="0" enableorderby="0" forceraster="0" type="singleSymbol">
    <symbols>
      <symbol name="0" force_rhr="0" type="line" alpha="1" clip_to_extent="1">
        <layer pass="0" class="SimpleLine" enabled="1" locked="0">
          <prop k="capstyle" v="square"/>
          <prop k="customdash" v="5;2"/>
          <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="customdash_unit" v="MM"/>
          <prop k="draw_inside_polygon" v="0"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="line_color" v="200,255,144,255"/>
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
    <alias name="" index="0" field="fid"/>
    <alias name="" index="1" field="osm_id"/>
    <alias name="" index="2" field="highway"/>
    <alias name="" index="3" field="bridge"/>
    <alias name="" index="4" field="name"/>
    <alias name="" index="5" field="oneway"/>
    <alias name="" index="6" field="junction"/>
    <alias name="" index="7" field="amenity"/>
    <alias name="" index="8" field="hstore_to_json"/>
  </aliases>
  <excludeAttributesWMS/>
  <excludeAttributesWFS/>
  <defaults>
    <default expression="" applyOnUpdate="0" field="fid"/>
    <default expression="" applyOnUpdate="0" field="osm_id"/>
    <default expression="" applyOnUpdate="0" field="highway"/>
    <default expression="" applyOnUpdate="0" field="bridge"/>
    <default expression="" applyOnUpdate="0" field="name"/>
    <default expression="" applyOnUpdate="0" field="oneway"/>
    <default expression="" applyOnUpdate="0" field="junction"/>
    <default expression="" applyOnUpdate="0" field="amenity"/>
    <default expression="" applyOnUpdate="0" field="hstore_to_json"/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" unique_strength="1" notnull_strength="1" constraints="3" field="fid"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" constraints="0" field="osm_id"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" constraints="0" field="highway"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" constraints="0" field="bridge"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" constraints="0" field="name"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" constraints="0" field="oneway"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" constraints="0" field="junction"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" constraints="0" field="amenity"/>
    <constraint exp_strength="0" unique_strength="0" notnull_strength="0" constraints="0" field="hstore_to_json"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"/>
    <constraint desc="" exp="" field="osm_id"/>
    <constraint desc="" exp="" field="highway"/>
    <constraint desc="" exp="" field="bridge"/>
    <constraint desc="" exp="" field="name"/>
    <constraint desc="" exp="" field="oneway"/>
    <constraint desc="" exp="" field="junction"/>
    <constraint desc="" exp="" field="amenity"/>
    <constraint desc="" exp="" field="hstore_to_json"/>
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
  <layerGeometryType>1</layerGeometryType>
</qgis>

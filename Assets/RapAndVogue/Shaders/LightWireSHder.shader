// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "LightWireSHder"
{
	Properties
	{
		_EmiPower("EmiPower", Float) = 1
		_Saturate("Saturate", Range( 0 , 1)) = 1
		_Value("Value", Range( 0 , 1)) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			half filler;
		};

		uniform float _EmiPower;
		uniform float _Saturate;
		uniform float _Value;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 transform1 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float temp_output_19_0 = pow( transform1.y , 1.46198 );
			float temp_output_13_0 = ( frac( ( transform1.x * 659.8746 ) ) * temp_output_19_0 * ( transform1.z * 0.75462 ) );
			float3 hsvTorgb15 = HSVToRGB( float3(frac( temp_output_13_0 ),_Saturate,_Value) );
			o.Emission = ( _EmiPower * hsvTorgb15 );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
868;73.6;1179;998;1693.089;1050.484;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;12;-665.6418,-390.8148;Float;False;Constant;_Float2;Float 2;0;0;Create;True;0;0;False;0;659.8746;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;1;-1177.193,-414.3153;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-473.9172,-431.6063;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-707.2286,-132.8639;Float;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;False;0;1.46198;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-514.9355,-107.4156;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;0.75462;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-325.7545,-200.4155;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;18;-319.2523,-418.4785;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;19;-483.6618,-281.1705;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-122.6815,-390.9099;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;108.2472,14.61105;Float;False;Property;_Value;Value;2;0;Create;True;0;0;True;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;110.6337,-71.89138;Float;False;Property;_Saturate;Saturate;1;0;Create;True;0;0;True;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;9;283.2897,-530.3846;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;472.3496,-225.4864;Float;False;Property;_EmiPower;EmiPower;0;0;Create;True;0;0;True;0;1;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;15;418.5,-85;Float;False;3;0;FLOAT;0.5;False;1;FLOAT;1;False;2;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldToObjectTransfNode;33;-136.8899,-79.86172;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TransformPositionNode;49;-309.3157,-715.2322;Float;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;651.4108,-119.4678;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-339.0204,-1073.592;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-536.9967,-1200.059;Float;False;Constant;_Float3;Float 3;0;0;Create;True;0;0;False;0;659.8746;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.InstanceIdNode;35;-809.873,-1358.629;Float;False;0;1;INT;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;40;-544.3469,-1119.797;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldTransformParams;44;-346.1159,-1420.832;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;14;-319.2992,-320.3441;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;37;-1020.157,214.9921;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TransformPositionNode;46;25.08411,-656.8324;Float;False;World;Object;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexIdVariableNode;34;-690.05,-1367.799;Float;False;0;1;INT;0
Node;AmplifyShaderEditor.WorldToObjectTransfNode;39;-793.8633,-1179.084;Float;False;1;0;FLOAT4;1,6.17,1,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;895,-233;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;LightWireSHder;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;1;1
WireConnection;10;1;12;0
WireConnection;3;0;1;3
WireConnection;3;1;4;0
WireConnection;18;0;10;0
WireConnection;19;0;1;2
WireConnection;19;1;7;0
WireConnection;13;0;18;0
WireConnection;13;1;19;0
WireConnection;13;2;3;0
WireConnection;9;0;13;0
WireConnection;15;0;9;0
WireConnection;15;1;20;0
WireConnection;15;2;24;0
WireConnection;16;0;17;0
WireConnection;16;1;15;0
WireConnection;32;0;30;0
WireConnection;32;1;40;1
WireConnection;14;0;19;0
WireConnection;46;0;13;0
WireConnection;0;2;16;0
ASEEND*/
//CHKSM=F581C095A72C3099CFBD7E93216D9B4359792E07
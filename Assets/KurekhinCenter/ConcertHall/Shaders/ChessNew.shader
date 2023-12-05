// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ChessNew"
{
	Properties
	{
		_PanelEmi5("PanelEmi5", 2D) = "white" {}
		_TimeScle("TimeScle", Float) = 0
		_Float0("Float 0", Float) = 5
		_EmissionColor("EmissionColor", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _EmissionColor;
		uniform sampler2D _PanelEmi5;
		uniform float4 _PanelEmi5_ST;
		uniform float _TimeScle;
		uniform float _Float0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_PanelEmi5 = i.uv_texcoord * _PanelEmi5_ST.xy + _PanelEmi5_ST.zw;
			float3 objToWorld22 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			uint currInstanceId = 0;
			#ifdef UNITY_INSTANCING_ENABLED
			currInstanceId = unity_InstanceID;
			#endif
			float3 objToWorld1 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			float mulTime5 = _Time.y * _TimeScle;
			o.Emission = ( _EmissionColor * ( tex2D( _PanelEmi5, uv_PanelEmi5 ) * round( frac( ( frac( pow( ( ( objToWorld22.y + currInstanceId ) + ( objToWorld1.x + currInstanceId ) ) , 3.0 ) ) * ( frac( mulTime5 ) + objToWorld22.y + objToWorld1.x ) ) ) ) * _Float0 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
1065.6;80.8;974;984;3243.372;1589.386;3.845749;True;False
Node;AmplifyShaderEditor.TransformPositionNode;22;-1457.878,-138.9401;Float;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.InstanceIdNode;21;-1324.239,162.5231;Float;False;0;1;INT;0
Node;AmplifyShaderEditor.TransformPositionNode;1;-1531.958,243.7013;Float;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.InstanceIdNode;2;-1398.319,545.1645;Float;False;0;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-1183.158,61.06547;Float;False;2;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-1210.438,357.9069;Float;False;2;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1333.86,757.2521;Float;False;Property;_TimeScle;TimeScle;1;0;Create;True;0;0;True;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-1072.636,182.712;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;5;-1096.912,735.7944;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;18;-876.0394,555.4174;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;15;-902.2123,308.7392;Float;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-636.5811,544.0529;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;16;-679.119,273.8967;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-524.0908,379.5223;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;20;-514.3812,29.25285;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-604.2067,-388.8638;Float;True;Property;_PanelEmi5;PanelEmi5;0;0;Create;True;0;0;False;0;c6adf519cfeab4949a83fd1b5a4691d4;c6adf519cfeab4949a83fd1b5a4691d4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-328.22,186.3714;Float;False;Property;_Float0;Float 0;2;0;Create;True;0;0;True;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RoundOpNode;10;-279.4655,-3.816442;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-257.9836,-386.6413;Float;False;Property;_EmissionColor;EmissionColor;3;0;Create;True;0;0;True;0;0,0,0,0;0.4144818,0.9100576,0,1.477947;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-17.71121,-73.70462;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SinOpNode;6;-655.7774,713.1784;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;179.7776,-159.4868;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;464.5445,-137.6625;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ChessNew;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;0;22;2
WireConnection;23;1;21;0
WireConnection;17;0;1;1
WireConnection;17;1;2;0
WireConnection;26;0;23;0
WireConnection;26;1;17;0
WireConnection;5;0;4;0
WireConnection;18;0;5;0
WireConnection;15;0;26;0
WireConnection;19;0;18;0
WireConnection;19;1;22;2
WireConnection;19;2;1;1
WireConnection;16;0;15;0
WireConnection;8;0;16;0
WireConnection;8;1;19;0
WireConnection;20;0;8;0
WireConnection;10;0;20;0
WireConnection;12;0;11;0
WireConnection;12;1;10;0
WireConnection;12;2;3;0
WireConnection;6;0;5;0
WireConnection;14;0;13;0
WireConnection;14;1;12;0
WireConnection;0;2;14;0
ASEEND*/
//CHKSM=C1D30D6D0A1DD68C91CB5FBA924ED7AED336ED92
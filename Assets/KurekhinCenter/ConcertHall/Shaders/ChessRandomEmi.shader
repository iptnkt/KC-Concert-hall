// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ChessRandomEmi"
{
	Properties
	{
		_FireSignA("FireSignA", 2D) = "white" {}
		_TimeScle("TimeScle", Float) = 0
		_FireSignE("FireSignE", 2D) = "white" {}
		_EmiPower("EmiPower", Float) = 1
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

		uniform sampler2D _FireSignA;
		uniform float4 _FireSignA_ST;
		uniform sampler2D _FireSignE;
		uniform float4 _FireSignE_ST;
		uniform float _TimeScle;
		uniform float _EmiPower;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_FireSignA = i.uv_texcoord * _FireSignA_ST.xy + _FireSignA_ST.zw;
			o.Albedo = tex2D( _FireSignA, uv_FireSignA ).rgb;
			float2 uv_FireSignE = i.uv_texcoord * _FireSignE_ST.xy + _FireSignE_ST.zw;
			float3 objToWorld16 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			uint currInstanceId = 0;
			#ifdef UNITY_INSTANCING_ENABLED
			currInstanceId = unity_InstanceID;
			#endif
			float3 objToWorld18 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			float mulTime23 = _Time.y * _TimeScle;
			o.Emission = ( tex2D( _FireSignE, uv_FireSignE ) * round( frac( ( frac( pow( ( ( objToWorld16.y + currInstanceId ) + ( objToWorld18.x + currInstanceId ) ) , 3.0 ) ) * ( frac( mulTime23 ) + objToWorld16.y + objToWorld18.x ) ) ) ) * _EmiPower ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
1413.6;80.8;626;984;1256.728;199.9355;1.563699;True;False
Node;AmplifyShaderEditor.TransformPositionNode;16;-1389.467,-43.34065;Float;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.InstanceIdNode;17;-1255.828,258.1224;Float;False;0;1;INT;0
Node;AmplifyShaderEditor.TransformPositionNode;18;-1463.547,339.3006;Float;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.InstanceIdNode;19;-1329.908,640.7639;Float;False;0;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-1142.026,453.5062;Float;False;2;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-1114.746,156.6649;Float;False;2;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1265.449,852.8514;Float;False;Property;_TimeScle;TimeScle;1;0;Create;True;0;0;True;0;0;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;23;-1028.501,831.3937;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-1004.224,278.3113;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;26;-833.8006,404.3385;Float;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;25;-807.6277,651.0168;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-568.1694,639.6523;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;28;-610.7073,369.496;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-455.679,475.1217;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;30;-445.9694,124.8522;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RoundOpNode;31;-211.0537,91.78295;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-569.5896,-564.2582;Float;True;Property;_FireSignE;FireSignE;2;0;Create;True;0;0;False;0;31c8897e258906e4fb671f73fb6cbfdf;31c8897e258906e4fb671f73fb6cbfdf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;32;-259.8082,281.9708;Float;False;Property;_EmiPower;EmiPower;3;0;Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-55.18173,-692.9441;Float;True;Property;_FireSignA;FireSignA;0;0;Create;True;0;0;False;0;aad6b66a02c931844a1c823dbbd3929e;aad6b66a02c931844a1c823dbbd3929e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;50.70059,21.89477;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SinOpNode;34;-587.3657,808.7778;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;366.8452,-511.1776;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ChessRandomEmi;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;22;0;18;1
WireConnection;22;1;19;0
WireConnection;21;0;16;2
WireConnection;21;1;17;0
WireConnection;23;0;20;0
WireConnection;24;0;21;0
WireConnection;24;1;22;0
WireConnection;26;0;24;0
WireConnection;25;0;23;0
WireConnection;27;0;25;0
WireConnection;27;1;16;2
WireConnection;27;2;18;1
WireConnection;28;0;26;0
WireConnection;29;0;28;0
WireConnection;29;1;27;0
WireConnection;30;0;29;0
WireConnection;31;0;30;0
WireConnection;33;0;11;0
WireConnection;33;1;31;0
WireConnection;33;2;32;0
WireConnection;34;0;23;0
WireConnection;0;0;8;0
WireConnection;0;2;33;0
ASEEND*/
//CHKSM=180E55803418EC58B6994259CC0B110CA8BE1FEF
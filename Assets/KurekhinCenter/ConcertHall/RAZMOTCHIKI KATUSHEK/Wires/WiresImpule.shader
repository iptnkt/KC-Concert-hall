// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WiresImpule"
{
	Properties
	{
		[Normal]_dirtywickerweave1normalogl("dirty-wicker-weave1-normal-ogl", 2D) = "bump" {}
		[Gamma]_dirtywickerweave1ao("dirty-wicker-weave1-ao", 2D) = "white" {}
		_Metalic("Metalic", Range( 0 , 1)) = 1
		_Smothness("Smothness", Range( 0 , 1)) = 1
		_scaleTIme("scaleTIme", Float) = 1
		_DistanceBeetwenImpulses("DistanceBeetwenImpulses", Float) = 1
		_ImpulseColor("ImpulseColor", Color) = (1,1,1,0)
		_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
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
			float2 uv3_texcoord3;
		};

		uniform sampler2D _dirtywickerweave1normalogl;
		uniform float4 _dirtywickerweave1normalogl_ST;
		uniform float4 _Color0;
		uniform float _DistanceBeetwenImpulses;
		uniform float _scaleTIme;
		uniform float4 _ImpulseColor;
		uniform sampler2D _dirtywickerweave1ao;
		uniform float4 _dirtywickerweave1ao_ST;
		uniform float _Metalic;
		uniform float _Smothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_dirtywickerweave1normalogl = i.uv_texcoord * _dirtywickerweave1normalogl_ST.xy + _dirtywickerweave1normalogl_ST.zw;
			o.Normal = UnpackNormal( tex2D( _dirtywickerweave1normalogl, uv_dirtywickerweave1normalogl ) );
			o.Albedo = _Color0.rgb;
			float mulTime5 = _Time.y * _scaleTIme;
			float2 uv_dirtywickerweave1ao = i.uv_texcoord * _dirtywickerweave1ao_ST.xy + _dirtywickerweave1ao_ST.zw;
			float4 tex2DNode2 = tex2D( _dirtywickerweave1ao, uv_dirtywickerweave1ao );
			float4 clampResult17 = clamp( ( ( ( sin( ( ( i.uv3_texcoord3.y * _DistanceBeetwenImpulses ) + mulTime5 ) ) * 100.0 ) - 99.0 ) * _ImpulseColor * tex2DNode2 ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			o.Emission = clampResult17.rgb;
			o.Metallic = _Metalic;
			o.Smoothness = _Smothness;
			o.Occlusion = tex2DNode2.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
971.2;80.8;1068;984;399.8821;196.6231;1.204408;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1164.984,895.0592;Float;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-1182.065,1272.265;Float;False;Property;_scaleTIme;scaleTIme;4;0;Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1058.396,1108.55;Float;False;Property;_DistanceBeetwenImpulses;DistanceBeetwenImpulses;5;0;Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-839.9841,1010.059;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;9;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;5;-993.7286,1291.832;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-646.9842,1002.059;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;9;-494.4085,949.2327;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-326.9106,921.7054;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-295.5,253;Float;True;Property;_dirtywickerweave1ao;dirty-wicker-weave1-ao;1;1;[Gamma];Create;True;0;0;False;0;e2c9b6a15a0a9f84886210adc952fbc0;e2c9b6a15a0a9f84886210adc952fbc0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;12;-83.09041,786.4774;Float;False;2;0;FLOAT;0;False;1;FLOAT;99;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-107.2368,1069.179;Float;False;Property;_ImpulseColor;ImpulseColor;6;0;Create;True;0;0;True;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;137.5804,759.1417;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;17;304.6968,362.2224;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;16;36.11404,-241.1861;Float;False;Property;_Color0;Color 0;7;0;Create;True;0;0;True;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;39.5,117;Float;False;Property;_Metalic;Metalic;2;0;Create;True;0;0;True;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-255.1611,177.4088;Float;False;Property;_Smothness;Smothness;3;0;Create;True;0;0;True;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-248.5,-95;Float;True;Property;_dirtywickerweave1normalogl;dirty-wicker-weave1-normal-ogl;0;1;[Normal];Create;True;0;0;False;0;c43190aaaa0229246a36afaa53bd6f4f;c43190aaaa0229246a36afaa53bd6f4f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;462.2363,45.18237;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;WiresImpule;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;7;2
WireConnection;8;1;15;0
WireConnection;5;0;6;0
WireConnection;10;0;8;0
WireConnection;10;1;5;0
WireConnection;9;0;10;0
WireConnection;11;0;9;0
WireConnection;12;0;11;0
WireConnection;13;0;12;0
WireConnection;13;1;14;0
WireConnection;13;2;2;0
WireConnection;17;0;13;0
WireConnection;0;0;16;0
WireConnection;0;1;1;0
WireConnection;0;2;17;0
WireConnection;0;3;4;0
WireConnection;0;4;3;0
WireConnection;0;5;2;0
ASEEND*/
//CHKSM=08AECA4186DF1F506BD277A7D879571E2B38818C
// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AnimatedDrawnings"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_AlphaDrawning("AlphaDrawning", 2D) = "white" {}
		_T_Voronoi_Noise("T_Voronoi_Noise", 2D) = "white" {}
		_TimeScale("TimeScale", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Back
		Blend One Zero , SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _AlphaDrawning;
		uniform float4 _AlphaDrawning_ST;
		uniform sampler2D _T_Voronoi_Noise;
		uniform float _TimeScale;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_AlphaDrawning = i.uv_texcoord * _AlphaDrawning_ST.xy + _AlphaDrawning_ST.zw;
			float4 tex2DNode1 = tex2D( _AlphaDrawning, uv_AlphaDrawning );
			o.Albedo = ( tex2DNode1 * float4( 0,0,0,0 ) ).rgb;
			o.Alpha = 1;
			float4 temp_cast_1 = (tex2DNode1.a).xxxx;
			float mulTime5 = _Time.y * _TimeScale;
			float2 temp_cast_2 = (mulTime5).xx;
			float2 uv_TexCoord6 = i.uv_texcoord + temp_cast_2;
			clip( ( temp_cast_1 - tex2D( _T_Voronoi_Noise, uv_TexCoord6 ) ).r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
1042.4;73.6;1005;998;760.9047;432.0611;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;7;-1416.645,-57.03021;Float;False;Property;_TimeScale;TimeScale;3;0;Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;5;-1133,-9;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-909,-82;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-609,66;Float;True;Property;_AlphaDrawning;AlphaDrawning;1;0;Create;True;0;0;False;0;4ee4979b57232164286d0f57d34fad9b;4ee4979b57232164286d0f57d34fad9b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-606,-189;Float;True;Property;_T_Voronoi_Noise;T_Voronoi_Noise;2;0;Create;True;0;0;False;0;71c08610deb243144888703479205c12;71c08610deb243144888703479205c12;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;3;-198,99;Float;False;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-172.0527,-270.6305;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;AnimatedDrawnings;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;TransparentCutout;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;7;0
WireConnection;6;1;5;0
WireConnection;2;1;6;0
WireConnection;3;0;1;4
WireConnection;3;1;2;0
WireConnection;8;0;1;0
WireConnection;0;0;8;0
WireConnection;0;10;3;0
ASEEND*/
//CHKSM=CC51EF8D716AD31896D40C28155322ED1B1A1305
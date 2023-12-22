// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Flag"
{
	Properties
	{
		_FranchFlag_Base_color("FranchFlag_Base_color", 2D) = "white" {}
		_FranchFlag_Normal_OpenGL("FranchFlag_Normal_OpenGL", 2D) = "white" {}
		_Float0("Float 0", Float) = 1
		_FranchFlag_Height("FranchFlag_Height", 2D) = "white" {}
		_Float1("Float 1", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _FranchFlag_Normal_OpenGL;
		uniform float4 _FranchFlag_Normal_OpenGL_ST;
		uniform sampler2D _FranchFlag_Base_color;
		uniform float4 _FranchFlag_Base_color_ST;
		uniform float _Float0;
		uniform sampler2D _FranchFlag_Height;
		uniform float4 _FranchFlag_Height_ST;
		uniform float _Float1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_FranchFlag_Normal_OpenGL = i.uv_texcoord * _FranchFlag_Normal_OpenGL_ST.xy + _FranchFlag_Normal_OpenGL_ST.zw;
			o.Normal = tex2D( _FranchFlag_Normal_OpenGL, uv_FranchFlag_Normal_OpenGL ).rgb;
			float2 uv_FranchFlag_Base_color = i.uv_texcoord * _FranchFlag_Base_color_ST.xy + _FranchFlag_Base_color_ST.zw;
			o.Albedo = tex2D( _FranchFlag_Base_color, uv_FranchFlag_Base_color ).rgb;
			o.Smoothness = _Float0;
			float2 uv_FranchFlag_Height = i.uv_texcoord * _FranchFlag_Height_ST.xy + _FranchFlag_Height_ST.zw;
			o.Occlusion = ( tex2D( _FranchFlag_Height, uv_FranchFlag_Height ) + _Float1 ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16800
1412;73.6;635;998;415.4728;151.9296;1.035087;True;False
Node;AmplifyShaderEditor.SamplerNode;5;-498,411;Float;True;Property;_FranchFlag_Height;FranchFlag_Height;3;0;Create;True;0;0;False;0;7efe39fa605604249b9a9888ff2e47f9;7efe39fa605604249b9a9888ff2e47f9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-386,605;Float;False;Property;_Float1;Float 1;4;0;Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-348,-101;Float;True;Property;_FranchFlag_Base_color;FranchFlag_Base_color;0;0;Create;True;0;0;False;0;c8fa3b5138fe02a4ea1177f28443fc42;c8fa3b5138fe02a4ea1177f28443fc42;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-573,78;Float;True;Property;_FranchFlag_Normal_OpenGL;FranchFlag_Normal_OpenGL;1;0;Create;True;0;0;False;0;75b1102a44772de40a1ea48984417917;75b1102a44772de40a1ea48984417917;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-259,236;Float;False;Property;_Float0;Float 0;2;0;Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-118.2456,459.8065;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;56,32;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Flag;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;5;0
WireConnection;8;1;7;0
WireConnection;0;0;1;0
WireConnection;0;1;3;0
WireConnection;0;4;4;0
WireConnection;0;5;8;0
ASEEND*/
//CHKSM=256289C6BABBDBBC5BDEAA9146B153BFD396484B
// Made with Amplify Shader Editor v1.9.1.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VHS-Animator"
{
	Properties
	{
		_Rows("Rows", Float) = 7
		_Columns("Columns", Float) = 8
		_Speed("Speed", Float) = 1
		_Glitch("Glitch", Range( 0 , 0.02)) = 0.0005
		_GlitchBrightness("Glitch Brightness", Range( 0 , 1)) = 0
		_ScanWidth("Scan Width", Range( 0 , 1)) = 0
		_Noise("Noise", 2D) = "white" {}
		_MainTex("MainTex", 2D) = "white" {}
		_SubdiscretizationX("Subdiscretization X", Float) = 1024
		_SubdiscretizationY("Subdiscretization Y", Float) = 1024
		_Subpixel("Subpixel", 2D) = "white" {}
		[RemapSliders]_FadeDistance("Fade Distance", Vector) = (0,0,0,0)
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
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _Subpixel;
		uniform float4 _Subpixel_ST;
		uniform float2 _FadeDistance;
		uniform float _GlitchBrightness;
		uniform sampler2D _Noise;
		uniform float4 _Noise_ST;
		uniform float _ScanWidth;
		uniform sampler2D _MainTex;
		uniform float _Glitch;
		uniform float _Columns;
		uniform float _Rows;
		uniform float _Speed;
		uniform float _SubdiscretizationX;
		uniform float _SubdiscretizationY;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Subpixel = i.uv_texcoord * _Subpixel_ST.xy + _Subpixel_ST.zw;
			float2 lerpResult107 = lerp( uv_Subpixel , ( uv_Subpixel + float2( 0,0.5 ) ) , round( frac( ( uv_Subpixel.x / 2.0 ) ) ));
			float3 ase_worldPos = i.worldPos;
			float2 break120 = ( _FadeDistance * float2( 1,1 ) );
			float smoothstepResult118 = smoothstep( 0.0 , 1.0 , (0.0 + (distance( _WorldSpaceCameraPos , ase_worldPos ) - break120.x) * (1.0 - 0.0) / (break120.y - break120.x)));
			float4 lerpResult111 = lerp( tex2D( _Subpixel, lerpResult107 ) , float4( 1,1,1,1 ) , smoothstepResult118);
			float temp_output_2_0_g11 = 0.95;
			float temp_output_3_0_g11 = 0.95;
			float2 appendResult21_g11 = (float2(temp_output_2_0_g11 , temp_output_3_0_g11));
			float Radius25_g11 = max( min( min( abs( ( 0.08 * 2 ) ) , abs( temp_output_2_0_g11 ) ) , abs( temp_output_3_0_g11 ) ) , 1E-05 );
			float2 temp_cast_0 = (0.0).xx;
			float temp_output_29_0_g11 = length( max( ( ( abs( (i.uv_texcoord*2.0 + -1.0) ) - appendResult21_g11 ) + Radius25_g11 ) , temp_cast_0 ) );
			float smoothstepResult129 = smoothstep( 0.0 , 1.0 , (0.0 + (-( temp_output_29_0_g11 - Radius25_g11 ) - 0.0) * (1.0 - 0.0) / (0.3 - 0.0)));
			float2 uv_Noise = i.uv_texcoord * _Noise_ST.xy + _Noise_ST.zw;
			float2 appendResult73 = (float2(( uv_Noise.x + _Time.y ) , uv_Noise.y));
			float4 tex2DNode70 = tex2D( _Noise, appendResult73 );
			float3 appendResult76 = (float3(tex2DNode70.r , tex2DNode70.g , tex2DNode70.b));
			float3 smoothstepResult75 = smoothstep( float3( 0,0,0 ) , float3( 1,1,1 ) , appendResult76);
			float mulTime35 = _Time.y * -0.7;
			float mulTime54 = _Time.y * 0.5;
			float smoothstepResult60 = smoothstep( ( 1.0 - _ScanWidth ) , 1.0 , ( ( 1.0 - abs( sin( ( ( i.uv_texcoord.y + mulTime35 ) * 1.0 ) ) ) ) * ( 1.0 - abs( sin( ( ( i.uv_texcoord.y + mulTime54 ) * 5.12 ) ) ) ) ));
			float temp_output_42_0 = saturate( smoothstepResult60 );
			float2 appendResult59 = (float2(_Glitch , 0.0));
			float3 temp_output_30_0 = ( ( (float3( -1,-1,-1 ) + (smoothstepResult75 - float3( 0,0,0 )) * (float3( 1,1,1 ) - float3( -1,-1,-1 )) / (float3( 1,1,1 ) - float3( 0,0,0 ))) * temp_output_42_0 ) * float3( ( appendResult59 * temp_output_42_0 ) ,  0.0 ) );
			// *** BEGIN Flipbook UV Animation vars ***
			// Total tiles of Flipbook Texture
			float fbtotaltiles1 = _Columns * _Rows;
			// Offsets for cols and rows of Flipbook Texture
			float fbcolsoffset1 = 1.0f / _Columns;
			float fbrowsoffset1 = 1.0f / _Rows;
			// Speed of animation
			float fbspeed1 = _Time.y * _Speed;
			// UV Tiling (col and row offset)
			float2 fbtiling1 = float2(fbcolsoffset1, fbrowsoffset1);
			// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
			// Calculate current tile linear index
			float fbcurrenttileindex1 = round( fmod( fbspeed1 + 0.0, fbtotaltiles1) );
			fbcurrenttileindex1 += ( fbcurrenttileindex1 < 0) ? fbtotaltiles1 : 0;
			// Obtain Offset X coordinate from current tile linear index
			float fblinearindextox1 = round ( fmod ( fbcurrenttileindex1, _Columns ) );
			// Multiply Offset X by coloffset
			float fboffsetx1 = fblinearindextox1 * fbcolsoffset1;
			// Obtain Offset Y coordinate from current tile linear index
			float fblinearindextoy1 = round( fmod( ( fbcurrenttileindex1 - fblinearindextox1 ) / _Columns, _Rows ) );
			// Reverse Y to get tiles from Top to Bottom
			fblinearindextoy1 = (int)(_Rows-1) - fblinearindextoy1;
			// Multiply Offset Y by rowoffset
			float fboffsety1 = fblinearindextoy1 * fbrowsoffset1;
			// UV Offset
			float2 fboffset1 = float2(fboffsetx1, fboffsety1);
			// Flipbook UV
			half2 fbuv1 = i.uv_texcoord * fbtiling1 + fboffset1;
			// *** END Flipbook UV Animation vars ***
			float pixelWidth87 =  1.0f / ( _Columns * _SubdiscretizationX );
			float pixelHeight87 = 1.0f / ( _Rows * _SubdiscretizationY );
			half2 pixelateduv87 = half2((int)((( -temp_output_30_0 + float3( fbuv1 ,  0.0 ) )).xy.x / pixelWidth87) * pixelWidth87, (int)((( -temp_output_30_0 + float3( fbuv1 ,  0.0 ) )).xy.y / pixelHeight87) * pixelHeight87);
			float3 break66 = mul( float3x3(0.299,0.587,0.114,-0.14713,-0.28886,0.436,0.615,-0.51499,-0.10001), tex2D( _MainTex, pixelateduv87 ).rgb );
			float3 appendResult68 = (float3(mul( float3x3(0.299,0.587,0.114,-0.14713,-0.28886,0.436,0.615,-0.51499,-0.10001), tex2D( _MainTex, ( temp_output_30_0 + float3( fbuv1 ,  0.0 ) ).xy ).rgb ).x , break66.y , break66.z));
			o.Emission = ( lerpResult111 * smoothstepResult129 * float4( ( ( _GlitchBrightness * smoothstepResult75 * temp_output_42_0 ) + mul( float3x3(1,0,1.13983,1,-0.39465,-0.5806,1,2.03211,0), appendResult68 ) ) , 0.0 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19102
Node;AmplifyShaderEditor.SaturateNode;42;-616.6553,-393.9362;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;52;-1264.822,-274.7042;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;39;-1265.848,-493.5797;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;38;-1432.383,-493.3776;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;48;-1432.566,-275.1103;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;49;-1603.957,-275.5751;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;34;-1602.775,-493.8423;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-1735.213,-494.6203;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-1861.657,-493.4232;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-1737.395,-275.3531;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;55;-1861.224,-276.8534;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;54;-2039.266,-252.4357;Inherit;False;1;0;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-1874.187,-183.0235;Inherit;False;Constant;_Float1;Float 0;7;0;Create;True;0;0;0;False;0;False;5.12;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;33;-2112.085,-543.1136;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-1072.661,-394.6477;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;60;-841.742,-394.289;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.25;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1298.594,-17.03015;Inherit;False;Property;_ScanWidth;Scan Width;5;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;62;-1031.594,-15.03015;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;59;-613.1107,-503.7167;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SmoothstepOpNode;75;-941.772,-1082.049;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;74;-734.7797,-941.0086;Inherit;False;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;3;FLOAT3;-1,-1,-1;False;4;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;79;379.3134,-199.9528;Inherit;True;Property;_TextureSample0;Texture Sample 0;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-341.9216,-476.9225;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1874.813,-396.0202;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;35;-2069.543,-408.1981;Inherit;False;1;0;FLOAT;-0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-653.4017,56.5683;Inherit;False;Property;_Rows;Rows;0;0;Create;True;0;0;0;False;0;False;7;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-654.5911,126.4618;Inherit;False;Property;_Speed;Speed;2;0;Create;True;0;0;0;False;0;False;1;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-656.4017,-15.18016;Inherit;False;Property;_Columns;Columns;1;0;Create;True;0;0;0;False;0;False;8;7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;6;-687.6918,196.953;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-729.4965,-127.9171;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCFlipBookUVAnimation;1;-488.0461,11.74263;Inherit;True;0;0;6;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;88;-764.508,386.7232;Inherit;False;Property;_SubdiscretizationX;Subdiscretization X;8;0;Create;True;0;0;0;False;0;False;1024;160;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-750.208,468.6233;Inherit;False;Property;_SubdiscretizationY;Subdiscretization Y;9;0;Create;True;0;0;0;False;0;False;1024;120;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;-495.7981,445.2428;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-459.7981,343.2428;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;64;667.7561,54.57885;Inherit;True;Property;_MainTex1;MainTex;3;0;Create;False;0;0;0;False;0;False;-1;None;7f51e64675a5e264fbd5729a07872b1d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCPixelate;87;392.1528,339.1375;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT;768;False;2;FLOAT;1024;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;93;187.7742,212.9794;Inherit;False;True;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;92;63.01295,178.1516;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;78;-443.6078,-203.6228;Inherit;True;Property;_MainTex;MainTex;7;0;Create;False;0;0;0;False;0;False;None;7f51e64675a5e264fbd5729a07872b1d;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-166.1956,-519.2535;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-466.7624,-866.6319;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;66;1206.298,113.9084;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;63;714.7706,-180.177;Inherit;False;RGB to YUV;-1;;5;1ed4207bbc7c91b469b45347cc23eb5f;0;1;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;67;884.5084,-179.9882;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;68;1401.99,-173.0298;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;132.8439,-323.0104;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;94;-86.23991,29.85939;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-910.8235,-509.4601;Inherit;False;Property;_Glitch;Glitch;3;0;Create;False;0;0;0;False;0;False;0.0005;0.02;0;0.02;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;107;1790.502,-1070.719;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FractNode;104;1492.244,-938.6313;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RoundOpNode;105;1614.375,-939.2344;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;110;1352.435,-918.9372;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;109;1544.364,-1040.578;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;101;1120.223,-1085.68;Inherit;False;0;99;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;99;1976.681,-1084.91;Inherit;True;Property;_Subpixel;Subpixel;10;0;Create;True;0;0;0;False;0;False;-1;None;bd2afbde847202a4b9e764c064138f9a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;111;2543.437,-1033.75;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,1;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;116;2046.437,-801.5507;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;3;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;113;1193.937,-799.1505;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;114;1258.937,-661.3504;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;112;1459.137,-791.3505;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;118;2284.89,-751.071;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;120;1836.89,-726.071;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector2Node;117;1475.89,-657.071;Inherit;False;Property;_FadeDistance;Fade Distance;11;1;[RemapSliders];Create;True;0;0;0;False;0;False;0,0;0.1137932,0.7172413;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;1660.89,-633.071;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;127;1805.876,-486.4199;Inherit;False;Constant;_Float2;Float 2;12;0;Create;True;0;0;0;False;0;False;0.95;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;128;1803.876,-562.4199;Inherit;False;Constant;_Float3;Float 2;12;0;Create;True;0;0;0;False;0;False;0.95;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;135;1997.416,-517.7686;Inherit;True;Rounded Rectangle;-1;;11;8679f72f5be758f47babb3ba1d5f51d3;0;4;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;2;FLOAT;0;FLOAT;39
Node;AmplifyShaderEditor.SimpleAddOpNode;45;1770.886,-212.9124;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;3095.73,-253.1855;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3247.931,-291.9383;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;VHS-Animator;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.NegateNode;131;2241.646,-496.136;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;136;2422.803,-495.1236;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.3;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;129;2685.739,-488.9196;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;787.0269,-653.9135;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;47;458.3017,-395.7526;Inherit;False;Property;_GlitchBrightness;Glitch Brightness;4;0;Create;True;0;0;0;False;0;False;0;0.64;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;1816.323,-399.7679;Inherit;False;Constant;_Float4;Float 4;12;0;Create;True;0;0;0;False;0;False;0.08;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;65;1017.735,139.4388;Inherit;False;RGB to YUV;-1;;4;1ed4207bbc7c91b469b45347cc23eb5f;0;1;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;69;1551.99,-176.0298;Inherit;False;YUV to RGB;-1;;6;41a6967b00edbeb4d9592156913ec406;0;1;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;71;-2255.28,-1118.098;Inherit;False;0;70;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;73;-1883.08,-1072.398;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;20;-2255.117,-940.9498;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;-2029.68,-1084.797;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;70;-1717.88,-1097.397;Inherit;True;Property;_Noise;Noise;6;0;Create;True;0;0;0;False;0;False;-1;None;05b1d9d0d8f3cf146a24b3385b2a1076;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;76;-1363.356,-1080.837;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
WireConnection;42;0;60;0
WireConnection;52;0;48;0
WireConnection;39;0;38;0
WireConnection;38;0;34;0
WireConnection;48;0;49;0
WireConnection;49;0;50;0
WireConnection;34;0;40;0
WireConnection;40;0;37;0
WireConnection;40;1;41;0
WireConnection;37;0;33;2
WireConnection;37;1;35;0
WireConnection;50;0;55;0
WireConnection;50;1;51;0
WireConnection;55;0;33;2
WireConnection;55;1;54;0
WireConnection;53;0;39;0
WireConnection;53;1;52;0
WireConnection;60;0;53;0
WireConnection;60;1;62;0
WireConnection;62;0;61;0
WireConnection;59;0;31;0
WireConnection;75;0;76;0
WireConnection;74;0;75;0
WireConnection;79;0;78;0
WireConnection;79;1;32;0
WireConnection;79;7;78;1
WireConnection;43;0;59;0
WireConnection;43;1;42;0
WireConnection;1;0;4;0
WireConnection;1;1;3;0
WireConnection;1;2;2;0
WireConnection;1;3;5;0
WireConnection;1;5;6;0
WireConnection;90;0;2;0
WireConnection;90;1;89;0
WireConnection;91;0;3;0
WireConnection;91;1;88;0
WireConnection;64;0;78;0
WireConnection;64;1;87;0
WireConnection;64;7;78;1
WireConnection;87;0;93;0
WireConnection;87;1;91;0
WireConnection;87;2;90;0
WireConnection;93;0;92;0
WireConnection;92;0;94;0
WireConnection;92;1;1;0
WireConnection;30;0;44;0
WireConnection;30;1;43;0
WireConnection;44;0;74;0
WireConnection;44;1;42;0
WireConnection;66;0;65;0
WireConnection;63;1;79;0
WireConnection;67;0;63;0
WireConnection;68;0;67;0
WireConnection;68;1;66;1
WireConnection;68;2;66;2
WireConnection;32;0;30;0
WireConnection;32;1;1;0
WireConnection;94;0;30;0
WireConnection;107;0;101;0
WireConnection;107;1;109;0
WireConnection;107;2;105;0
WireConnection;104;0;110;0
WireConnection;105;0;104;0
WireConnection;110;0;101;1
WireConnection;109;0;101;0
WireConnection;99;1;107;0
WireConnection;111;0;99;0
WireConnection;111;2;118;0
WireConnection;116;0;112;0
WireConnection;116;1;120;0
WireConnection;116;2;120;1
WireConnection;112;0;113;0
WireConnection;112;1;114;0
WireConnection;118;0;116;0
WireConnection;120;0;119;0
WireConnection;119;0;117;0
WireConnection;135;2;128;0
WireConnection;135;3;127;0
WireConnection;135;4;134;0
WireConnection;45;0;46;0
WireConnection;45;1;69;0
WireConnection;100;0;111;0
WireConnection;100;1;129;0
WireConnection;100;2;45;0
WireConnection;0;2;100;0
WireConnection;131;0;135;39
WireConnection;136;0;131;0
WireConnection;129;0;136;0
WireConnection;46;0;47;0
WireConnection;46;1;75;0
WireConnection;46;2;42;0
WireConnection;65;1;64;0
WireConnection;69;1;68;0
WireConnection;73;0;72;0
WireConnection;73;1;71;2
WireConnection;72;0;71;1
WireConnection;72;1;20;0
WireConnection;70;1;73;0
WireConnection;76;0;70;1
WireConnection;76;1;70;2
WireConnection;76;2;70;3
ASEEND*/
//CHKSM=38450B096041BD164866EBBE79E77844537E9F53
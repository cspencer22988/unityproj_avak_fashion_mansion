Shader "LKWD/Cutout/LightmapTweak Wind Double" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
		_LightmapGain ("Lightmap gain amount", Float) = 0.5
		_LightmapFlatten ("Lightmap flatten multiplier", Float) = 0.66
		_WindMainFlutter ("Wind main flutter factor", Float) = 0.5
		_WindEdgeFlutter ("Wind edge flutter factor", Float) = 0.1
		_WindFlutterFrequency ("Wind flutter frequency", Float) = 0.5
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			Cull Off
			GpuProgramID 5511
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = worldPosition_1.xyz;
					  gl_Position = (unity_MatrixVP * tmpvar_9);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = worldPosition_1.xyz;
					  gl_Position = (unity_MatrixVP * tmpvar_9);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = worldPosition_1.xyz;
					  gl_Position = (unity_MatrixVP * tmpvar_9);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((tmpvar_9.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 final_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
					  final_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
					  lowp float x_4;
					  x_4 = (tmpvar_2.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((tmpvar_9.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 final_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
					  final_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
					  lowp float x_4;
					  x_4 = (tmpvar_2.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((tmpvar_9.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 final_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
					  final_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
					  lowp float x_4;
					  x_4 = (tmpvar_2.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_9.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 final_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
					  final_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
					  lowp float x_4;
					  x_4 = (tmpvar_2.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_9.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 final_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
					  final_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
					  lowp float x_4;
					  x_4 = (tmpvar_2.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_9.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 final_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
					  final_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
					  lowp float x_4;
					  x_4 = (tmpvar_2.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_EXP2" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  highp float tmpvar_11;
					  tmpvar_11 = (unity_FogParams.x * tmpvar_9.z);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = exp2((-(tmpvar_11) * tmpvar_11));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 final_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
					  final_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
					  lowp float x_4;
					  x_4 = (tmpvar_2.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_EXP2" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  highp float tmpvar_11;
					  tmpvar_11 = (unity_FogParams.x * tmpvar_9.z);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = exp2((-(tmpvar_11) * tmpvar_11));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 final_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
					  final_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
					  lowp float x_4;
					  x_4 = (tmpvar_2.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_EXP2" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  highp float tmpvar_11;
					  tmpvar_11 = (unity_FogParams.x * tmpvar_9.z);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = exp2((-(tmpvar_11) * tmpvar_11));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 final_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
					  final_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(tmpvar_3));
					  lowp float x_4;
					  x_4 = (tmpvar_2.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTMAP_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = worldPosition_1.xyz;
					  gl_Position = (unity_MatrixVP * tmpvar_9);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  lowp float x_8;
					  x_8 = (tmpvar_3.w - _Cutoff);
					  if ((x_8 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTMAP_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = worldPosition_1.xyz;
					  gl_Position = (unity_MatrixVP * tmpvar_9);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  lowp float x_8;
					  x_8 = (tmpvar_3.w - _Cutoff);
					  if ((x_8 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTMAP_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = worldPosition_1.xyz;
					  gl_Position = (unity_MatrixVP * tmpvar_9);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  lowp float x_8;
					  x_8 = (tmpvar_3.w - _Cutoff);
					  if ((x_8 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_TEXCOORD2 = ((tmpvar_9.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
					  final_2.xyz = mix (unity_FogColor.xyz, final_2.xyz, vec3(tmpvar_8));
					  lowp float x_9;
					  x_9 = (tmpvar_3.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_TEXCOORD2 = ((tmpvar_9.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
					  final_2.xyz = mix (unity_FogColor.xyz, final_2.xyz, vec3(tmpvar_8));
					  lowp float x_9;
					  x_9 = (tmpvar_3.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_TEXCOORD2 = ((tmpvar_9.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
					  final_2.xyz = mix (unity_FogColor.xyz, final_2.xyz, vec3(tmpvar_8));
					  lowp float x_9;
					  x_9 = (tmpvar_3.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_TEXCOORD2 = exp2(-((unity_FogParams.y * tmpvar_9.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
					  final_2.xyz = mix (unity_FogColor.xyz, final_2.xyz, vec3(tmpvar_8));
					  lowp float x_9;
					  x_9 = (tmpvar_3.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_TEXCOORD2 = exp2(-((unity_FogParams.y * tmpvar_9.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
					  final_2.xyz = mix (unity_FogColor.xyz, final_2.xyz, vec3(tmpvar_8));
					  lowp float x_9;
					  x_9 = (tmpvar_3.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_TEXCOORD2 = exp2(-((unity_FogParams.y * tmpvar_9.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
					  final_2.xyz = mix (unity_FogColor.xyz, final_2.xyz, vec3(tmpvar_8));
					  lowp float x_9;
					  x_9 = (tmpvar_3.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP2" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  highp float tmpvar_11;
					  tmpvar_11 = (unity_FogParams.x * tmpvar_9.z);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_TEXCOORD2 = exp2((-(tmpvar_11) * tmpvar_11));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
					  final_2.xyz = mix (unity_FogColor.xyz, final_2.xyz, vec3(tmpvar_8));
					  lowp float x_9;
					  x_9 = (tmpvar_3.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP2" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  highp float tmpvar_11;
					  tmpvar_11 = (unity_FogParams.x * tmpvar_9.z);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_TEXCOORD2 = exp2((-(tmpvar_11) * tmpvar_11));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
					  final_2.xyz = mix (unity_FogColor.xyz, final_2.xyz, vec3(tmpvar_8));
					  lowp float x_9;
					  x_9 = (tmpvar_3.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP2" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _WindMainFlutter;
					uniform highp float _WindEdgeFlutter;
					uniform highp float _WindFlutterFrequency;
					uniform highp float _WindGlobalIntensity;
					uniform highp vec3 _WindGlobalDirection;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 worldPosition_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
					  worldPosition_1.w = tmpvar_2.w;
					  highp float tmpvar_3;
					  tmpvar_3 = (dot (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0)) * 0.01);
					  highp vec2 tmpvar_4;
					  tmpvar_4.x = (tmpvar_3 * 8.0);
					  tmpvar_4.y = tmpvar_3;
					  highp vec4 tmpvar_5;
					  tmpvar_5 = abs(((
					    fract((((
					      fract(((tmpvar_4 + (_Time.y * _WindFlutterFrequency)).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
					     * 2.0) - 1.0) + 0.5))
					   * 2.0) - 1.0));
					  highp vec4 tmpvar_6;
					  tmpvar_6 = ((tmpvar_5 * tmpvar_5) * (3.0 - (2.0 * tmpvar_5)));
					  highp vec2 tmpvar_7;
					  tmpvar_7 = (tmpvar_6.xz + tmpvar_6.yw);
					  worldPosition_1.xyz = (tmpvar_2.xyz + (_WindGlobalDirection * (
					    (_WindMainFlutter * tmpvar_7.y)
					   * 
					    (_glesColor.z * _WindGlobalIntensity)
					  )));
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  worldPosition_1.xyz = (worldPosition_1.xyz + (normalize(
					    (_glesNormal * tmpvar_8)
					  ) * (
					    (_WindEdgeFlutter * tmpvar_7.x)
					   * 
					    (_glesColor.x * _WindGlobalIntensity)
					  )));
					  highp vec4 tmpvar_9;
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldPosition_1.xyz;
					  tmpvar_9 = (unity_MatrixVP * tmpvar_10);
					  highp float tmpvar_11;
					  tmpvar_11 = (unity_FogParams.x * tmpvar_9.z);
					  gl_Position = tmpvar_9;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  xlv_TEXCOORD2 = exp2((-(tmpvar_11) * tmpvar_11));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform mediump sampler2D unity_Lightmap;
					uniform mediump vec4 unity_Lightmap_HDR;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					uniform highp float _LightmapGain;
					uniform highp float _LightmapFlatten;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lightmap_1;
					  lowp vec4 final_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  final_2.w = tmpvar_3.w;
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
					  lowp vec4 color_5;
					  color_5 = tmpvar_4;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (unity_Lightmap_HDR.x * color_5.xyz);
					  lightmap_1 = tmpvar_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((lightmap_1 + _LightmapGain) * _LightmapFlatten);
					  lightmap_1 = tmpvar_7;
					  final_2.xyz = (tmpvar_3.xyz * tmpvar_7);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
					  final_2.xyz = mix (unity_FogColor.xyz, final_2.xyz, vec3(tmpvar_8));
					  lowp float x_9;
					  x_9 = (tmpvar_3.w - _Cutoff);
					  if ((x_9 < 0.0)) {
					    discard;
					  };
					  gl_FragData[0] = final_2;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_EXP" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_EXP" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_EXP" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_EXP2" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_EXP2" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_EXP2" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTMAP_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTMAP_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTMAP_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP2" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP2" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTMAP_ON" "FOG_EXP2" }
					"!!GLES"
				}
			}
		}
		Pass {
			Name "META"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "META" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			Cull Off
			GpuProgramID 82462
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					attribute vec4 _glesMultiTexCoord2;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 unity_DynamicLightmapST;
					uniform bvec4 unity_MetaVertexControl;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying mediump vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  mediump vec4 tmpvar_2;
					  highp vec4 vertex_3;
					  vertex_3 = _glesVertex;
					  if (unity_MetaVertexControl.x) {
					    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					    highp float tmpvar_4;
					    if ((_glesVertex.z > 0.0)) {
					      tmpvar_4 = 0.0001;
					    } else {
					      tmpvar_4 = 0.0;
					    };
					    vertex_3.z = tmpvar_4;
					  };
					  if (unity_MetaVertexControl.y) {
					    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
					    highp float tmpvar_5;
					    if ((vertex_3.z > 0.0)) {
					      tmpvar_5 = 0.0001;
					    } else {
					      tmpvar_5 = 0.0;
					    };
					    vertex_3.z = tmpvar_5;
					  };
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = vertex_3.xyz;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = vec2(0.0, 0.0);
					  xlv_TEXCOORD2 = vec2(0.0, 0.0);
					  xlv_TEXCOORD3 = vec2(0.0, 0.0);
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform bvec4 unity_MetaFragmentControl;
					uniform highp float unity_OneOverOutputBoost;
					uniform highp float unity_MaxOutputValue;
					uniform highp float unity_UseLinearSpace;
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 col_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1 = tmpvar_4;
					  tmpvar_2 = (col_1.xyz * col_1.w);
					  mediump vec4 res_5;
					  res_5 = vec4(0.0, 0.0, 0.0, 0.0);
					  if (unity_MetaFragmentControl.x) {
					    mediump vec4 tmpvar_6;
					    tmpvar_6.w = 1.0;
					    tmpvar_6.xyz = tmpvar_2;
					    res_5.w = tmpvar_6.w;
					    highp vec3 tmpvar_7;
					    tmpvar_7 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
					    res_5.xyz = tmpvar_7;
					  };
					  if (unity_MetaFragmentControl.y) {
					    mediump vec3 emission_8;
					    if (bool(unity_UseLinearSpace)) {
					      emission_8 = tmpvar_3;
					    } else {
					      emission_8 = (tmpvar_3 * ((tmpvar_3 * 
					        ((tmpvar_3 * 0.305306) + 0.6821711)
					      ) + 0.01252288));
					    };
					    mediump vec4 tmpvar_9;
					    tmpvar_9.w = 1.0;
					    tmpvar_9.xyz = emission_8;
					    res_5 = tmpvar_9;
					  };
					  gl_FragData[0] = res_5;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					attribute vec4 _glesMultiTexCoord2;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 unity_DynamicLightmapST;
					uniform bvec4 unity_MetaVertexControl;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying mediump vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  mediump vec4 tmpvar_2;
					  highp vec4 vertex_3;
					  vertex_3 = _glesVertex;
					  if (unity_MetaVertexControl.x) {
					    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					    highp float tmpvar_4;
					    if ((_glesVertex.z > 0.0)) {
					      tmpvar_4 = 0.0001;
					    } else {
					      tmpvar_4 = 0.0;
					    };
					    vertex_3.z = tmpvar_4;
					  };
					  if (unity_MetaVertexControl.y) {
					    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
					    highp float tmpvar_5;
					    if ((vertex_3.z > 0.0)) {
					      tmpvar_5 = 0.0001;
					    } else {
					      tmpvar_5 = 0.0;
					    };
					    vertex_3.z = tmpvar_5;
					  };
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = vertex_3.xyz;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = vec2(0.0, 0.0);
					  xlv_TEXCOORD2 = vec2(0.0, 0.0);
					  xlv_TEXCOORD3 = vec2(0.0, 0.0);
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform bvec4 unity_MetaFragmentControl;
					uniform highp float unity_OneOverOutputBoost;
					uniform highp float unity_MaxOutputValue;
					uniform highp float unity_UseLinearSpace;
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 col_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1 = tmpvar_4;
					  tmpvar_2 = (col_1.xyz * col_1.w);
					  mediump vec4 res_5;
					  res_5 = vec4(0.0, 0.0, 0.0, 0.0);
					  if (unity_MetaFragmentControl.x) {
					    mediump vec4 tmpvar_6;
					    tmpvar_6.w = 1.0;
					    tmpvar_6.xyz = tmpvar_2;
					    res_5.w = tmpvar_6.w;
					    highp vec3 tmpvar_7;
					    tmpvar_7 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
					    res_5.xyz = tmpvar_7;
					  };
					  if (unity_MetaFragmentControl.y) {
					    mediump vec3 emission_8;
					    if (bool(unity_UseLinearSpace)) {
					      emission_8 = tmpvar_3;
					    } else {
					      emission_8 = (tmpvar_3 * ((tmpvar_3 * 
					        ((tmpvar_3 * 0.305306) + 0.6821711)
					      ) + 0.01252288));
					    };
					    mediump vec4 tmpvar_9;
					    tmpvar_9.w = 1.0;
					    tmpvar_9.xyz = emission_8;
					    res_5 = tmpvar_9;
					  };
					  gl_FragData[0] = res_5;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					attribute vec4 _glesMultiTexCoord2;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 unity_DynamicLightmapST;
					uniform bvec4 unity_MetaVertexControl;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying mediump vec4 xlv_COLOR0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesColor;
					  mediump vec4 tmpvar_2;
					  highp vec4 vertex_3;
					  vertex_3 = _glesVertex;
					  if (unity_MetaVertexControl.x) {
					    vertex_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					    highp float tmpvar_4;
					    if ((_glesVertex.z > 0.0)) {
					      tmpvar_4 = 0.0001;
					    } else {
					      tmpvar_4 = 0.0;
					    };
					    vertex_3.z = tmpvar_4;
					  };
					  if (unity_MetaVertexControl.y) {
					    vertex_3.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
					    highp float tmpvar_5;
					    if ((vertex_3.z > 0.0)) {
					      tmpvar_5 = 0.0001;
					    } else {
					      tmpvar_5 = 0.0;
					    };
					    vertex_3.z = tmpvar_5;
					  };
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = vertex_3.xyz;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = vec2(0.0, 0.0);
					  xlv_TEXCOORD2 = vec2(0.0, 0.0);
					  xlv_TEXCOORD3 = vec2(0.0, 0.0);
					  xlv_COLOR0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform bvec4 unity_MetaFragmentControl;
					uniform highp float unity_OneOverOutputBoost;
					uniform highp float unity_MaxOutputValue;
					uniform highp float unity_UseLinearSpace;
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 col_1;
					  mediump vec3 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1 = tmpvar_4;
					  tmpvar_2 = (col_1.xyz * col_1.w);
					  mediump vec4 res_5;
					  res_5 = vec4(0.0, 0.0, 0.0, 0.0);
					  if (unity_MetaFragmentControl.x) {
					    mediump vec4 tmpvar_6;
					    tmpvar_6.w = 1.0;
					    tmpvar_6.xyz = tmpvar_2;
					    res_5.w = tmpvar_6.w;
					    highp vec3 tmpvar_7;
					    tmpvar_7 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
					    res_5.xyz = tmpvar_7;
					  };
					  if (unity_MetaFragmentControl.y) {
					    mediump vec3 emission_8;
					    if (bool(unity_UseLinearSpace)) {
					      emission_8 = tmpvar_3;
					    } else {
					      emission_8 = (tmpvar_3 * ((tmpvar_3 * 
					        ((tmpvar_3 * 0.305306) + 0.6821711)
					      ) + 0.01252288));
					    };
					    mediump vec4 tmpvar_9;
					    tmpvar_9.w = 1.0;
					    tmpvar_9.xyz = emission_8;
					    res_5 = tmpvar_9;
					  };
					  gl_FragData[0] = res_5;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
			}
		}
	}
	Fallback "LKWD/Cutout/LightmapTweak"
}
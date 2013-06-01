version:"v1.0"
type:"sprite2d"
name:"main"
resourceNu:13
resources:[
	"textures/flame01.png"
	"textures/flame02.png"
	"textures/flame03.png"
	"textures/flame04.png"
	"textures/block.png"
	"textures/explode01.png"
	"textures/explode02.png"
	"textures/explode03.png"
	"textures/explode04.png"
	"textures/signal_01.png"
	"textures/signal_02.png"
	"textures/signal_03.png"
	"textures/signal_04.png"
]
animations:[
	{
		name:"text"
		fps:4
		frameNu:4
		keyFrames:[
			#frame 0
			[
				{
					texture:0
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-320.000000,64.000000,320.000000,64.000000,320.000000,-64.000000,-320.000000,-64.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 1
			[
				{
					texture:1
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-320.000000,64.000000,320.000000,64.000000,320.000000,-64.000000,-320.000000,-64.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 2
			[
				{
					texture:2
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-320.000000,64.000000,320.000000,64.000000,320.000000,-64.000000,-320.000000,-64.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 3
			[
				{
					texture:3
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-320.000000,64.000000,320.000000,64.000000,320.000000,-64.000000,-320.000000,-64.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
		]
	}
	{
		name:"block"
		fps:10
		frameNu:11
		keyFrames:[
			#frame 0
			[
				{
					texture:4
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-64.000023,175.401642,-64.000015,367.401642,63.999981,367.401642,63.999977,175.401642]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 1
			[
				{
					texture:4
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-64.000023,149.168045,-64.000023,341.168060,63.999985,341.168030,63.999981,149.168030]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 2
			[
				{
					texture:4
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-64.000015,122.934425,-64.000015,314.934418,63.999989,314.934418,63.999985,122.934425]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 3
			[
				{
					texture:4
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-64.000015,96.700821,-64.000015,288.700836,63.999992,288.700806,63.999985,96.700821]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 4
			[
				{
					texture:4
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-64.000008,70.467216,-64.000008,262.467224,63.999996,262.467224,63.999989,70.467216]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 5
			[
				{
					texture:4
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-64.000008,44.233604,-64.000008,236.233612,64.000000,236.233597,63.999992,44.233604]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 6
			[
				{
					texture:4
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-64.000000,18.000002,-63.999996,210.000000,64.000000,210.000000,63.999996,17.999998]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 7
			[
				{
					texture:4
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-64.000000,0.000002,-63.999996,192.000000,64.000000,192.000000,63.999996,-0.000002]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
				{
					texture:5
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[32.000000,128.000000,160.000000,128.000000,160.000000,0.000000,32.000000,0.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
				{
					texture:5
					texcoord:[1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000]
					vertex:[-96.000000,128.000000,32.000000,128.000000,32.000000,0.000000,-96.000000,0.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 8
			[
				{
					texture:4
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-64.000000,0.000002,-63.999996,192.000000,64.000000,192.000000,63.999996,-0.000002]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
				{
					texture:6
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[32.000000,128.000000,160.000000,128.000000,160.000000,0.000000,32.000000,0.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
				{
					texture:6
					texcoord:[1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000]
					vertex:[-96.000000,128.000000,32.000000,128.000000,32.000000,0.000000,-96.000000,0.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 9
			[
				{
					texture:4
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-64.000000,0.000002,-63.999996,192.000000,64.000000,192.000000,63.999996,-0.000002]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
				{
					texture:7
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[32.000000,128.000000,160.000000,128.000000,160.000000,0.000000,32.000000,0.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
				{
					texture:7
					texcoord:[1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000]
					vertex:[-96.000000,128.000000,32.000000,128.000000,32.000000,0.000000,-96.000000,0.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 10
			[
				{
					texture:4
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-64.000000,0.000002,-63.999996,192.000000,64.000000,192.000000,63.999996,-0.000002]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
				{
					texture:8
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[32.000000,128.000000,160.000000,128.000000,160.000000,0.000000,32.000000,0.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
				{
					texture:8
					texcoord:[1.000000,0.000000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000]
					vertex:[-88.000000,128.000000,40.000000,128.000000,40.000000,0.000000,-88.000000,0.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
		]
	}
	{
		name:"game"
		fps:4
		frameNu:4
		keyFrames:[
			#frame 0
			[
				{
					texture:5
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-128.000000,128.000000,128.000000,128.000000,128.000000,-128.000000,-128.000000,-128.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 1
			[
				{
					texture:6
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-128.000000,128.000000,128.000000,128.000000,128.000000,-128.000000,-128.000000,-128.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 2
			[
				{
					texture:7
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-128.000000,128.000000,128.000000,128.000000,128.000000,-128.000000,-128.000000,-128.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 3
			[
				{
					texture:8
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-128.000000,128.000000,128.000000,128.000000,128.000000,-128.000000,-128.000000,-128.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
		]
	}
	{
		name:"signal"
		fps:4
		frameNu:4
		keyFrames:[
			#frame 0
			[
				{
					texture:9
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-256.000000,256.000000,256.000000,256.000000,256.000000,-256.000000,-256.000000,-256.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 1
			[
				{
					texture:10
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-256.000000,256.000000,256.000000,256.000000,256.000000,-256.000000,-256.000000,-256.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 2
			[
				{
					texture:11
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-256.000000,256.000000,256.000000,256.000000,256.000000,-256.000000,-256.000000,-256.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
			#frame 3
			[
				{
					texture:12
					texcoord:[0.000000,0.000000,1.000000,0.000000,1.000000,1.000000,0.000000,1.000000]
					vertex:[-256.000000,256.000000,256.000000,256.000000,256.000000,-256.000000,-256.000000,-256.000000]
					alpha:[1.000000,1.000000,1.000000,1.000000]
				}
			]
		]
	}
]

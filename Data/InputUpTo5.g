C2 := CyclicGroup(2);;
C4 := CyclicGroup(4);;
C6 := CyclicGroup(6);;
C10 := CyclicGroup(10);;

D8 := DihedralGroup(8);;
D12 := DihedralGroup(12);;
D20 := DihedralGroup(20);;

GaloisGroupsData := [
	# Размерность 1
	[
		# Ord(G) = 2
		C2
	],
	# Размерность 2
	[
		# Ord(G) = 4
		C4,
		# Ord(G) = 8
		D8
	],
	# Размерность 3
	[
		# Direct part
		# Ord(G) = 6
		C6,
		# Ord(G) = 12
		D12,
		
		# Semidirect part
		# Ord(G) = 24
		SmallGroup([ 24, 13 ]),
		# Ord(G) = 48
		SmallGroup([ 48, 48 ])
	],
	# Размерность 4
	[
		SmallGroup([ 8, 1 ]),
		SmallGroup([ 8, 2 ]),
		SmallGroup([ 8, 3 ]),
		SmallGroup([ 8, 4 ]),
		SmallGroup([ 8, 5 ]),

		SmallGroup([ 16, 3 ]),
		SmallGroup([ 16, 6 ]),
		SmallGroup([ 16, 7 ]),
		SmallGroup([ 16, 8 ]),
		SmallGroup([ 16, 11 ]),
		SmallGroup([ 16, 13 ]),

		SmallGroup([ 24, 3 ]),
		SmallGroup([ 24, 13 ]),

		SmallGroup([ 32, 6 ]),
		SmallGroup([ 32, 7 ]),
		SmallGroup([ 32, 11 ]),
		SmallGroup([ 32, 27 ]),
		SmallGroup([ 32, 43 ]),
		SmallGroup([ 32, 49 ]),

		SmallGroup([ 48, 29 ]),
		SmallGroup([ 48, 48 ]),

		SmallGroup([ 64, 32 ]),
		SmallGroup([ 64, 34 ]),
		SmallGroup([ 64, 134 ]),
		SmallGroup([ 64, 138 ]),

		SmallGroup([ 96, 204 ]),

		SmallGroup([ 128, 928 ]),

		SmallGroup([ 192, 201 ]),
		SmallGroup([ 192, 1493 ]),

		SmallGroup([ 384, 5602 ])
	],
	# Размерность 5
	[
		# Direct part
		# Ord(G) = 10
		C10,
		# Ord(G) = 20
		D20,
		# Ord(G) = 40
		SmallGroup(40, 12),
		# Ord(G) = 120
		SmallGroup(120, 35),
		# Ord(G) = 240
		SmallGroup(240, 189),
		
		# Semidirect part
		# Ord(G) = 160
		SmallGroup(160, 235),
		# Ord(G) = 320
		SmallGroup(320, 1636),
		# Ord(G) = 640
		SmallGroup(640, 21536),
		# Ord(G) = 1920
		SmallGroup(1920, 240997),
		# Ord(G) = 3840
		Group([ (1,9,7,5,3)(2,10,8,6,4), (7,8), (1,4)(2,3) ])
	]
];;
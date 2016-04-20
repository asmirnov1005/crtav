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
	]
];;
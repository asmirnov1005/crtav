C2 := CyclicGroup(2);;
C4 := CyclicGroup(4);;
C6 := CyclicGroup(6);;
C10 := CyclicGroup(10);;

D8 := DihedralGroup(8);;
D12 := DihedralGroup(12);;
D20 := DihedralGroup(20);;

GaloisGroupsData := [
	# Размерность 1
	[],
	# Размерность 2
	[],
	# Размерность 3
	[],
	# Размерность 4
	[],
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
return [
# Dimension 1
  rec(
    ("(1, 1)") := [
      "FV"
    ],
    ("(2, 1)") := [
      "F*V"
    ]
  ),
# Dimension 2
  rec(
    ("(1, 1)") := [
      "FFVV"
    ],
    ("(2, 1)") := [
      "(F*V)*(F*V)",
      "FV*FV"
    ],
    ("(2, 2)") := [
      "FV*FV"
    ],
    ("(3, 2)") := [
      "(F*V)*FV"
    ],
    ("(4, 2)") := [
      "(F*V)*(F*V)"
    ],
  ),
# Dimension 3
  rec(
    ("(1, 1)") := [
      "FFFVVV",
      "FV*FV*FV"
    ],
    ("(2, 1)") := [
      "(F*V)*(F*V)*(F*V)",
      "FFV*VVF"
    ],
    ("(2, 2)") := [
      "FFVV*FV"
    ],
    ("(3, 2)") := [
      "(F*V)*(F*V)*FV",
      "(F*V)*FFVV",
      "FV*FV*FV"
    ],
    ("(3, 3)") := [
      "FV*FV*FV"
    ],
    ("(4, 2)") := [
      "(F*V)*(F*V)*(F*V)",
      "(F*V)*FV*FV"
    ],
    ("(4, 3)") := [
      "(F*V)*FV*FV"
    ],
    ("(5, 3)") := [
      "(F*V)*(F*V)*FV"
    ],
    ("(6, 3)") := [
      "(F*V)*(F*V)*(F*V)"
    ],
  ),
# Dimension 4
  rec(
    ("(1, 1)") := [
      "FFFFVVVV",
      "FVFFVFVV"
    ],
    ("(2, 1)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)",
      "FFFV*VVVF",
      "FFVV*FFVV",
      "FV*FV*FV*FV"
    ],
    ("(2, 2)") := [
      "FFFVVV*FV",
      "FFVV*FFVV",
      "FV*FV*FV*FV"
    ],
    ("(3, 2)") := [
      "(F*V)*(F*V)*(F*V)*FV",
      "(F*V)*(F*V)*FFVV",
      "(F*V)*FFFVVV",
      "(F*V)*FV*FV*FV",
      "(FFV*VVF)*FV",
      "FFVV*FV*FV"
    ],
    ("(3, 3)") := [
      "FFVV*FV*FV"
    ],
    ("(4, 2)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)",
      "(F*V)*(F*V)*FV*FV",
      "(F*V)*(FFV*VVF)",
      "FV*FV*FV*FV"
    ],
    ("(4, 3)") := [
      "(F*V)*(F*V)*FV*FV",
      "(F*V)*FFVV*FV",
      "FV*FV*FV*FV"
    ],
    ("(4, 4)") := [
      "FV*FV*FV*FV"
    ],
    ("(5, 3)") := [
      "(F*V)*(F*V)*(F*V)*FV",
      "(F*V)*(F*V)*FFVV",
      "(F*V)*FV*FV*FV"
    ],
    ("(5, 4)") := [
      "(F*V)*FV*FV*FV"
    ],
    ("(6, 3)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)",
      "(F*V)*(F*V)*FV*FV"
    ],
    ("(6, 4)") := [
      "(F*V)*(F*V)*FV*FV"
    ],
    ("(7, 4)") := [
      "(F*V)*(F*V)*(F*V)*FV"
    ],
    ("(8, 4)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)"
    ],
  ),
# Dimension 5
  rec(
    ("(1, 1)") := [
      "FFFFFVVVVV",
      "FVFFFVFVVV",
      "FFVFFVVFVV",
      "FV*FV*FV*FV*FV"
    ],
    ("(2, 1)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)*(F*V)",
      "FFFFV*VVVVF",
      "FFFVV*VVVFF",
      "FFVFV*VVFVF"
    ],
    ("(2, 2)") := [
      "FFFFVVVV*FV",
      "FFFVVV*FFVV",
      "FV*FVFFVFVV",
      "FFVV*FV*FV*FV"
    ],
    ("(3, 2)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)*FV",
      "(F*V)*(F*V)*(F*V)*FFVV",
      "(F*V)*(F*V)*FV*FV*FV",
      "(F*V)*(F*V)*FFFVVV",
      "(F*V)*FFFFVVVV",
      "(F*V)*FVFFVFVV",
      "(FFFV*VVVF)*FV",
      "(FFV*VVF)*FFVV",
      "FFFVVV*FV*FV",
      "FFVV*FFVV*FV",
      "FV*FV*FV*FV*FV"
    ],
    ("(3, 3)") := [
      "FFFVVV*FV*FV",
      "FFVV*FFVV*FV",
      "FV*FV*FV*FV*FV"
    ],
    ("(4, 2)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)*(F*V)",
      "(F*V)*(F*V)*(F*V)*FV*FV",
      "(F*V)*(F*V)*(FFV*VVF)",
      "(F*V)*(FFFV*VVVF)",
      "(F*V)*FFVV*FFVV",
      "(F*V)*FV*FV*FV*FV",
      "(FFV*VVF)*FV*FV"
    ],
    ("(4, 3)") := [
      "(F*V)*(F*V)*(F*V)*FV*FV",
      "(F*V)*(F*V)*FFVV*FV",
      "(F*V)*FFFVVV*FV",
      "(F*V)*FFVV*FFVV",
      "(F*V)*FV*FV*FV*FV",
      "(FFV*VVF)*FV*FV",
      "FFVV*FV*FV*FV"
    ],
    ("(4, 4)") := [
      "FFVV*FV*FV*FV"
    ],
    ("(5, 3)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)*FV",
      "(F*V)*(F*V)*(F*V)*FFVV",
      "(F*V)*(F*V)*FFFVVV",
      "(F*V)*(F*V)*FV*FV*FV",
      "(F*V)*(FFV*VVF)*FV",
      "(F*V)*FFVV*FV*FV",
      "FV*FV*FV*FV*FV"
    ],
    ("(5, 4)") := [
      "(F*V)*(F*V)*FV*FV*FV",
      "(F*V)*FFVV*FV*FV",
      "FV*FV*FV*FV*FV"
    ],
    ("(5, 5)") := [
      "FV*FV*FV*FV*FV"
    ],
    ("(6, 3)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)*(F*V)",
      "(F*V)*(F*V)*(F*V)*FV*FV",
      "(F*V)*(F*V)*(FFV*VVF)",
      "(F*V)*FV*FV*FV*FV"
    ],
    ("(6, 4)") := [
      "(F*V)*(F*V)*(F*V)*FV*FV",
      "(F*V)*(F*V)*FFVV*FV",
      "(F*V)*FV*FV*FV*FV"
    ],
    ("(6, 5)") := [
      "(F*V)*FV*FV*FV*FV"
    ],
    ("(7, 4)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)*FV",
      "(F*V)*(F*V)*(F*V)*FFVV",
      "(F*V)*(F*V)*FV*FV*FV"
    ],
    ("(7, 5)") := [
      "(F*V)*(F*V)*FV*FV*FV"
    ],
    ("(8, 4)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)*(F*V)",
      "(F*V)*(F*V)*(F*V)*FV*FV"
    ],
    ("(8, 5)") := [
      "(F*V)*(F*V)*(F*V)*FV*FV"
    ],
    ("(9, 5)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)*FV"
    ],
    ("(10, 5)") := [
      "(F*V)*(F*V)*(F*V)*(F*V)*(F*V)"
    ],
  )
];
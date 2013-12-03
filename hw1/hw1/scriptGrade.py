import chem
f = """C27
H28
Br2
O5
S
(NH4)3PO4
Al6O13Si2
Au2(SeO4)3
Ba(C2H3O2)2
Ba2Na(NbO3)5
CH3(CH2)16COOH
CH3COO(CH2)2CH(CH3)2
(CH3)3COOC(CH3)3
(C2H5)2NH
C12H22O11
C164H256Na2O68S2
[Cu(H2O)4]SO4
HC12H17ON4SCl2
Hg3(AsO4)2
Mg3(Si2O5)(OH)4
Mg3(Si4O10)(OH)2
Mg3(VO4)2
Mn(CHO2)2
MnPb8(Si2O7)3
NH2C6H4SO3H
(NH4)2[Pt(SCN)6]
(NH4)2Hg(SCN)4
NaAu(CN)2
NaNH2C6H4SO3
Na2MoS4
Na3[Co(CO3)3]
Ni3(PO4)2
Ni(VO3)2
Tl(C3H3O4)
Zn(C8H15O2)2
Zn(NbO3)2
Zn3(AsO4)2
Zr3(PO4)4
MgNaAl5(Si4O10)3(OH)6
Mg2Al(AlSiO5)(OH)4
H
V
I
Sg
Br
Cm
Hf
HF
Ra
Th
Pa
DbSg
ZrNb
SnSbTa
CeCEu
CO2
H2O
He56
Fe5Ce243
At16W5V2
K2S12P3
O2O12He9
Au23Pa45Am
Lu 23 Li   5 Li	1  I 642
(Lu23Li 5)
[Li 4 Lu 11]
Fe(Fe(Fe[Fe]))
(((He)He)He)He2
H2(H50)2H
H2(O3)2(Cm12Ni4)3
H2O	{comment}
H2O {comment} {and another comment}
H2{O}
H{2{O}}
Ne12(Sc3(GaTc]3)
Eu(NdKr]
HsMt2Sg(Tl]
(H2O(H2O)((H2O)))
(((Cf)))
[[[Cf]]]"""
#((He2[[O2]]4(((([[Mo]]))))))
#Gd2 Tb Dy5(DyTb3) 6
#[[Gd2 Tb Dy5(DyTb3) 6]]
#(((Gd2 Tb Dy5(DyTb3) 6)))
#(Gd2 Tb Dy5(DyTb3) 6){45}
#((Gd2 Tb Dy5(([Dy])Tb3) 6)){2}3
#Gd 2 Tb Dy5 (Dy Tb    3) 6 Dy5{comment}At
#(Gd 2 Tb Dy5 (Dy Tb    3) 6 Dy5{comment}At)(HLi)
#(Gd 2 Tb Dy5 (Dy Tb    3) 6 Dy5{comment}At)(HLi)25
#[(Gd	 2 (Tb2 (([Dy5])))3 (Dy Tb{1000}    3) 6 Dy5{comment}([[[At2]{1000}]2])3)(HLi)25]Li	Lu 5


ex="""Hb
Israel
G e
ge
(CO2]
[CO2)
[Yb2(La5He7]]
(Yb2[La5He7]]
(Yb2[La5He7]2Fe6
(((((((Eu)))])))"""


formulas = f.split('\n')

exceps = ex.split('\n')

weight = ['324.2889', '28.22232', '159.808', '79.997', '32.065', '149.08678', '426.0522', '822.8058', '255.41504', '1002.1667', '284.47724', '130.18486', '146.22732', '73.13684', '342.29648', '3425.85604', '231.66972', '337.26852', '879.6084', '277.11236', '379.26568', '302.7932', '144.97288', '2217.0384', '173.18968', '579.64932', '468.99652', '271.991', '195.17144', '270.1794', '307.929', '366.023', '256.5728', '307.43682', '351.797', '347.1992', '474.0084', '653.5576', '1101.25424', '278.68486', '1.00794', '50.9415', '126.9045', '266', '79.904', '247', '178.49', '20.00634', '226', '232.0381', '231.0359', '528', '184.1304', '421.4179', '304.0907', '44.0095', '18.01528', '224.1456', '34327.413', '4380.875', '555.898', '260.015', '15169.906', '85538.576', '4058.946', '1952.401', '223.38', '20.013', '103.81782', '9694.33308', '18.01528', '18.01528', '2.01588', '1.00794', '242.1564', '151.964', '1079', '54.04584', '251', '251', '231.9404', '5121.5807', '5121.5807', '5121.5807', '5121.5807', '15364.7421', '6144.0677', '6152.01664', '6342.7912', '11954.0507']

if __name__ == '__main__':
  
  print ('--------- Test Started ---------')


  res=0   #Counter of correct results
  nonStaticMethod=0 #indicates whether readMoleculeFromString is not a static method

  #positive tests - no exceptions expected



for i in range(len(formulas)):
    try:
        mol, remaining = chem.Chem.readMoleculeFromString(formulas[i])
        if not((float(weight[i])+ 0.01 > mol.computeWeight()) and (float(weight[i])- 0.01 < mol.computeWeight())):
            print ('Test:', str(mol), ', Expected:', weight[i], ', Result:', str(mol.computeWeight()))
        else:
            res=res+1
    except: #print 'Result: exception. Trying to address readMoleculeFromString as non static method.'
        try:
            mol, remaining = chem.Chem.readMoleculeFromString(formulas[i])
            if not((float(weight[i])+ 0.01 > mol.computeWeight()) and (float(weight[i])- 0.01 < mol.computeWeight())):
                print ('Test:', str(mol), ', Expected:', weight[i], ', Result:', str(mol.computeWeight()))
            else:
                res = res+1
                nonStaticMethod=1
        except:
            print ('Test:', formulas[i], ', Expected:', weight[i], ', Result: Exception')


print ('------ Exceptions testing ------')

  #negative tests - exceptions expected

for j in range(len(exceps)):
    try:
        mol, remaining = chem.Chem.readMoleculeFromString(exceps[j])
        print ('Test:', exceps[j], ', Expected: exception', ', Result: no exception')
    except chem.pc.NoMatch as e:
        res=res+2
    except chem.NoSuchAtom as e:
        res=res+2
    except:
        #print 'Result: general exception. Trying to address readMoleculeFromString as non static method.'
        try:
           c=chem.Chem()
           mol, remaining = c.readMoleculeFromString(exceps[j])
           print ('Test:', exceps[j], ', Expected: exception', ', Result: no exception')
           nonStaticMethod=1
        except chem.pc.NoMatch as e:
               res=res+2
               nonStaticMethod=1
        except chem.NoSuchAtom as e:
            res=res+2
            nonStaticMethod=1
        except:
           print ('Test:', exceps[j], ', Expected: exception', ', Result: not a correct exception.')

print ('---------- Test Ended ----------')
if nonStaticMethod==1:
    print ('Grade=', res-40)
else:
    print ('Grade=', res)

# test.py
# Tests for the chemical noatation of molecules parser.
#
# Programmer: Kobi Aton, 2013

from hw1 import chemxxx
import unittest

#weight for molecules 1-40, weight 0 for: don't test weight
weightList = [0,624.38122, 149.08678, 426.0522, 822.8058, 255.41503999999998, 1002.1667000000001,
              284.47724, 130.18486, 146.22732, 73.13684, 342.29648, 3425.8560399999997, 231.66972, 337.26852,
              879.6084, 277.11235999999997, 379.26568, 302.79319999999996, 144.97288, 2217.0384, 173.18968,
              579.64932, 468.99652000000003, 271.991, 195.17144, 270.1794, 307.929, 366.023, 256.5728, 307.43682,
              351.79699999999997, 347.1992, 474.0084, 653.5576000000001, 1101.2542400000002, 278.68485999999996,
              44.0095, 98.07848, 50.08028, 34.08088]

# test number: {'input': '<input for the parser>','string': '<result for __str__>', 'weight':'<result for computeWeight or 0>','inParam': <Atom that belong to the molecule>, 'notInParam':<Atom that not belong to the molecule>}
TestTable = {
    1 : {'input': '   {     fdfds}   {dfdfd{fdfd}} C{dffd}27 H{O}28 Br2 O5{dfdfdf} S  {{{CO2}}}', 'string':'C27H28Br2O5S', 'weight':weightList[1], 'inParam': Atom('H'), 'notInParam': Atom('Ir')},
    2 : {'input': '   (  {fdfdfd{fdfdf(()]}} N{hhjhj}H4   )   3 {{}}PO4{fdgf}', 'string':'(NH4)3PO4', 'weight':weightList[2], 'inParam': Atom('H'), 'notInParam': Atom('Ir')},
    3 : {'input': 'Al6O13Si2', 'string':'Al6O13Si2', 'weight':weightList[3], 'inParam': Atom('Si'), 'notInParam': Atom('Ir')},
    4 : {'input': 'Au2(SeO4)3', 'string':'Au2(SeO4)3', 'weight':weightList[4], 'inParam': Atom('Au'), 'notInParam': Atom('Ir')},
    5 : {'input': '    Ba{fggfg}({{fggfgf{{fgfgf}}gfgf}fggf}C  2   H  3O2   )  {}  2', 'string':'Ba(C2H3O2)2', 'weight':weightList[5], 'inParam': Atom('Ba'), 'notInParam': Atom('Ir')},
    6 : {'input': 'Ba2Na(NbO3)5', 'string':'Ba2Na(NbO3)5', 'weight':weightList[6], 'inParam': Atom('Nb'), 'notInParam': Atom('Ir')},
    7 : {'input': 'C{gfgfgf}H{33}3{00}  (  {{}}CH2{  }){0}16COOH', 'string':'CH3(CH2)16COOH', 'weight':weightList[7], 'inParam': Atom('H'), 'notInParam': Atom('Ir')},
    8 : {'input': 'CH3COO(CH2)2CH(CH3)2', 'string':'CH3COO(CH2)2CH(CH3)2', 'weight':weightList[8], 'inParam': Atom('H'), 'notInParam': Atom('Ir')},
    9 : {'input': '(CH3)3COOC(CH3)3', 'string':'(CH3)3COOC(CH3)3', 'weight':weightList[9], 'inParam': Atom('O'), 'notInParam': Atom('Ir')},
    10 : {'input': '(C2H5)2NH', 'string':'(C2H5)2NH', 'weight':weightList[10], 'inParam': Atom('N'), 'notInParam': Atom('Ir')},
    11 : {'input': 'C12H22O11', 'string':'C12H22O11', 'weight':weightList[11], 'inParam': Atom('H'), 'notInParam': Atom('Ir')},
    12 : {'input': 'C164H256Na2O68S2', 'string':'C164H256Na2O68S2', 'weight':weightList[12], 'inParam': Atom('Na'), 'notInParam': Atom('Ir')},
    13 : {'input': '[{   } Cu{fdfdfd}(H2O{dfdfd}   )4   {dffdfd{ fdfdfd}CO2}]SO{Ir}4{0}', 'string':'Cu(H2O)4SO4', 'weight':weightList[13], 'inParam': Atom('Cu'), 'notInParam': Atom('Ir')},
    14 : {'input': """    {fggfgfgf}{ggffg{fggfgf}}{O}
HC12H17ON4SCl2
{ghgfhffhg} {ghghgh}{}{}{{{}}}{CO2}   """, 'string':'HC12H17ON4SCl2', 'weight':weightList[14], 'inParam': Atom('S'), 'notInParam': Atom('Ir')},
    15 : {'input': 'Hg3(AsO4)2', 'string':'Hg3(AsO4)2', 'weight':weightList[15], 'inParam': Atom('As'), 'notInParam': Atom('Ir')},
    16 : {'input': 'Mg3(Si2O5)(OH)4', 'string':'Mg3Si2O5(OH)4', 'weight':weightList[16], 'inParam': Atom('Mg'), 'notInParam': Atom('Ir')},
    17 : {'input': 'Mg3(Si4O10)(OH)2', 'string':'Mg3Si4O10(OH)2', 'weight':weightList[17], 'inParam': Atom('Si'), 'notInParam': Atom('Ir')},
    18 : {'input': 'Mg3(VO4)2', 'string':'Mg3(VO4)2', 'weight':weightList[18], 'inParam': Atom('V'), 'notInParam': Atom('Ir')},
    19 : {'input': 'Mn(CHO2)2', 'string':'Mn(CHO2)2', 'weight':weightList[19], 'inParam': Atom('Mn'), 'notInParam': Atom('Ir')},
    20 : {'input': 'MnPb8(Si2O7)3', 'string':'MnPb8(Si2O7)3', 'weight':weightList[20], 'inParam': Atom('Pb'), 'notInParam': Atom('Ir')},
    21 : {'input': 'NH2C6H4SO3H', 'string':'NH2C6H4SO3H', 'weight':weightList[21], 'inParam': Atom('H'), 'notInParam': Atom('Ir')},
    22 : {'input': '(NH4)2[Pt(SCN)6]', 'string':'(NH4)2Pt(SCN)6', 'weight':weightList[22], 'inParam': Atom('H'), 'notInParam': Atom('Ir')},
    23 : {'input': '(NH4)2Hg(SCN)4', 'string':'(NH4)2Hg(SCN)4', 'weight':weightList[23], 'inParam': Atom('Hg'), 'notInParam': Atom('Ir')},
    24 : {'input': 'NaAu(CN)2', 'string':'NaAu(CN)2', 'weight':weightList[24], 'inParam': Atom('Na'), 'notInParam': Atom('Ir')},
    25 : {'input': 'NaNH2C6H4SO3', 'string':'NaNH2C6H4SO3', 'weight':weightList[25], 'inParam': Atom('H'), 'notInParam': Atom('Ir')},
    26 : {'input': 'Na2MoS4', 'string':'Na2MoS4', 'weight':weightList[26], 'inParam': Atom('Mo'), 'notInParam': Atom('Ir')},
    27 : {'input': 'Na3[Co(CO3)3]', 'string':'Na3Co(CO3)3', 'weight':weightList[27], 'inParam': Atom('Na'), 'notInParam': Atom('Ir')},
    28 : {'input': 'Ni3(PO4)2', 'string':'Ni3(PO4)2', 'weight':weightList[28], 'inParam': Atom('Ni'), 'notInParam': Atom('Ir')},
    29 : {'input': 'Ni(VO3)2', 'string':'Ni(VO3)2', 'weight':weightList[29], 'inParam': Atom('V'), 'notInParam': Atom('Ir')},
    30 : {'input': 'Tl(C3H3O4)', 'string':'TlC3H3O4', 'weight':weightList[30], 'inParam': Atom('Tl'), 'notInParam': Atom('Ir')},
    31 : {'input': 'Zn(C8H15O2)2', 'string':'Zn(C8H15O2)2', 'weight':weightList[31], 'inParam': Atom('Zn'), 'notInParam': Atom('Ir')},
    32 : {'input': 'Zn(NbO3)2', 'string':'Zn(NbO3)2', 'weight':weightList[32], 'inParam': Atom('Zn'), 'notInParam': Atom('Ir')},
    33 : {'input': 'Zn3(AsO4)2', 'string':'Zn3(AsO4)2', 'weight':weightList[33], 'inParam': Atom('Zn'), 'notInParam': Atom('Ir')},
    34 : {'input': 'Zr3(PO4)4', 'string':'Zr3(PO4)4', 'weight':weightList[34], 'inParam': Atom('Zr'), 'notInParam': Atom('Ir')},
    35 : {'input': 'MgNaAl5(Si4O10)3(OH)6', 'string':'MgNaAl5(Si4O10)3(OH)6', 'weight':weightList[35], 'inParam': Atom('Mg'), 'notInParam': Atom('Ir')},
    36 : {'input': 'Mg2Al(AlSiO5)(OH)4', 'string':'Mg2AlAlSiO5(OH)4', 'weight':weightList[36], 'inParam': Atom('Si'), 'notInParam': Atom('Ir')},
    37 : {'input': """

{ Comments are in braces -- {they can be nested!}

}

CO2
""", 'string':'CO2', 'weight':weightList[37], 'inParam': Atom('C'), 'notInParam': Atom('W')},
    38 : {'input': 'H2SO4', 'string':'H2SO4', 'weight':weightList[38], 'inParam': Atom('S'), 'notInParam': Atom('Ir')},
    39 : {'input': 'H2SO{4} {not a real molecule}', 'string':'H2SO', 'weight':weightList[39], 'inParam': Atom('S'), 'notInParam': Atom('Ir')},
    40 : {'input': 'H2S{O{4}} {H2S stinks like hell!}', 'string':'H2S', 'weight':weightList[40], 'inParam': Atom('S'), 'notInParam': Atom('O')},
    41 : {'input': 'Fe4 [Fe (CN)6]3', 'string':'Fe4(Fe(CN)6)3', 'weight':weightList[0], 'inParam': Atom('Fe'), 'notInParam': Atom('Ir')},
    42 : {'input': 'Fe4 (Fe (CN)6]3', 'string':'Fe4', 'weight':weightList[0], 'inParam': Atom('Fe'), 'notInParam': Atom('C')},
    43 : {'input': '(H)2((O)2)', 'string':'H2O2', 'weight':weightList[0], 'inParam': Atom('H'), 'notInParam': Atom('Ir')},
    44 : {'input': '((Al)2)((((S)O4)3))', 'string':'Al2(SO4)3', 'weight':weightList[0], 'inParam': Atom('Al'), 'notInParam': Atom('Ir')},
    45 : {'input': 'C27 {lala} H28 Br2 O5 {{lulu} is back in town!} S', 'string':'C27H28Br2O5S', 'weight':weightList[0], 'inParam': Atom('C'), 'notInParam': Atom('Lu')},
    46 : {'input': 'HF', 'string':'HF', 'weight':20.00634, 'inParam': Atom('H'), 'notInParam': Atom('Hf')},
    47 : {'input': 'Hf', 'string':'Hf', 'weight':178.49, 'inParam': Atom('Hf'), 'notInParam': Atom('H')},
    48 : {'input': 'H0', 'string':'H', 'weight':1.00794, 'inParam': Atom('H'), 'notInParam': Atom('Hf')},
    49 : {'input': 'H01', 'string':'H', 'weight':1.00794, 'inParam': Atom('H'), 'notInParam': Atom('Hf')},
    50 : {'input': 'H1', 'string':'H', 'weight':1.00794, 'inParam': Atom('H'), 'notInParam': Atom('Hf')},
    51 : {'input': 'F()e', 'string':'F', 'weight':18.9984, 'inParam': Atom('F'), 'notInParam': Atom('Fe')},
    52 : {'input': 'H(2)', 'string':'H', 'weight':1.00794, 'inParam': Atom('H'), 'notInParam': Atom('Hf')},
    53 : {'input': 'H1(2)', 'string':'H', 'weight':1.00794, 'inParam': Atom('H'), 'notInParam': Atom('Hf')},
    54 : {'input': 'H3(2)', 'string':'H3', 'weight':3.02382, 'inParam': Atom('H'), 'notInParam': Atom('Hf')},
    55 : {'input': 'H()2O', 'string':'H', 'weight':1.00794, 'inParam': Atom('H'), 'notInParam': Atom('Hf')}
}


class TestError(Exception):
    def __init__(self, symbol):
        self.symbol = symbol

def run():
    print('start...')
    for e in TestTable.items():
        try:
            mol, remaining = Chem.readMoleculeFromString(e[1]['input'])
        except NoSuchAtom:
            print ('test '+str(e[0])+' in readMoleculeFromString')
        except NoMatch:
            print ('test '+str(e[0])+' in readMoleculeFromString')

        passTest=True

        if str(mol)!=e[1]['string']:
            print ('test '+str(e[0])+': error in string, get ' +str(mol))
            passTest=False
        if e[1]['weight'] and abs(e[1]['weight']-mol.computeWeight())>0.001:
            print ('test '+str(e[0])+': error in weight, get ' +str(mol.computeWeight())+' need to be: '+str(e[1]['weight']))
            passTest=False

        if not (e[1]['inParam'] in mol):
            print ('test '+str(e[0])+': error in inParam')
            passTest=False

        if e[1]['notInParam'] in mol:
            print ('test '+str(e[0])+': error in notInParam')
            passTest=False

        if passTest:
            print ('test '+str(e[0])+' pass')

    testNum=e[0]+1
    #exception test 1
    try:
        m, s = Chem.readMoleculeFromString('[NH4)3PO4')
        print('test '+str(testNum)+': exception test 1 fail')
    except pc.NoMatch as e:
        print ('test '+str(testNum)+' pass')

    testNum+=1

    #exception test 2
    try:
        m, s = Chem.readMoleculeFromString('Iran')
        print('test '+str(testNum)+': exception test 2 fail')
    except NoSuchAtom as e:
        print ('test '+str(testNum)+' pass')

    testNum+=1

    #exception test 3
    mol, remaining = Chem.readMoleculeFromString('Fe4 (Fe (CN)6]3')
    try:
        mol, remaining = Chem.readMoleculeFromString(remaining)
        print('test '+str(testNum)+': exception test 3 fail')
    except pc.NoMatch as e:
        print ('test '+str(testNum)+' pass')

    testNum+=1

    #exception test 4
    m, s = Chem.readMoleculeFromString('H()2O')
    try:
        m, s = Chem.readMoleculeFromString(s)
        print('test '+str(testNum)+': exception test 4 fail')
    except pc.NoMatch as e:
        print ('test '+str(testNum)+' pass')

    testNum+=1

    #exception test 5
    try:
        m, s = Chem.readMoleculeFromString('()H2O')
        print('test '+str(testNum)+': exception test 5 fail')
    except pc.NoMatch as e:
        print ('test '+str(testNum)+' pass')


    print('complete :)')





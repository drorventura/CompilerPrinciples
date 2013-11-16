from hw1 import chem
import unittest


class ChemUnitTests(unittest.TestCase):
	
    #------------------------ atoms tests ----------------------

    def test_symbol(self):
        a = chem.Atom('He')
        self.assertTrue(a.symbol == 'He')

    def test_number(self):
        a = chem.Atom('He')
        self.assertTrue(a.number == 2)

    def test_name(self):
        a = chem.Atom('He')
        self.assertTrue(a.name == 'Helium')

    def test_weight(self):
        a = chem.Atom('He')
        self.assertTrue(a.weight == 4.0026)

    def test_falseName(self):
        a = chem.Atom('He')
        self.assertFalse(a.symbol == 'Iran')

    def test_raiseNoSuchAtomException(self):
    	self.assertRaises(chem.NoSuchAtom, chem.Atom, ('Daniel', 'Algebra', 'JKFlipFlop'))

    def test_str(self):
        a = chem.Atom('He')
        self.assertTrue(str(a)=='He')
    
    #----------------------- molecule tests --------------------------

    def test_str(self):
        mol, remaining = chem.Chem.readMoleculeFromString('CO2')
        self.assertTrue(str(mol)=='CO2')

    def test_contains(self):
        mol, remaining = chem.Chem.readMoleculeFromString('CO2')
        self.assertTrue(chem.Atom('C') in mol)

    def test_contains2(self):
        mol, remaining = chem.Chem.readMoleculeFromString('CO2')
        self.assertTrue(chem.Atom('O') in mol)

    def test_containsFalse(self):
        mol, remaining = chem.Chem.readMoleculeFromString('CO2')
        self.assertFalse(chem.Atom('W') in mol)
    
    def test_computeWeight(self):
        mol, remaining = chem.Chem.readMoleculeFromString('H2SO4')
        self.assertTrue(mol.computeWeight() == 98.07848)

    def test_commentParanteces(self):
        mol, remaining = chem.Chem.readMoleculeFromString('H2S{O{4}} {His name is Robert Paulson}')
        self.assertTrue(str(mol)=='H2S')
        self.assertFalse(chem.Atom('O') in mol)

    def test_spacesAndBrackets(self):
        mol, remaining = chem.Chem.readMoleculeFromString('Fe4 [Fe (CN)6]3')
        self.assertTrue(str(mol)=='Fe4(Fe(CN)6)3')
        self.assertTrue(remaining == '')

    def test_weirdTest(self):
        mol, remaining = chem.Chem.readMoleculeFromString('Fe4 (Fe (CN)6]3')
        self.assertTrue(str(mol)=='Fe4')
        self.assertTrue(remaining == '(Fe (CN)6]3')

    def test_parantesesShit(self):
        mol, remaining = chem.Chem.readMoleculeFromString('(H)2((O)2)')
        self.assertTrue(str(mol)=='H2O2')
        mol, remaining = chem.Chem.readMoleculeFromString('((Al)2)((((S)O4)3))')
        self.assertTrue(str(mol)=='Al2(SO4)3')

    def tests_containsHardcoreTest(self):
        mol, remaining = chem.Chem.readMoleculeFromString('C27 {lala} H28 Br2 O5 {{lulu} is back in town!} S')
        self.assertTrue(chem.Atom('C') in mol)
        self.assertTrue(chem.Atom('H') in mol)
        self.assertTrue(chem.Atom('Br') in mol)
        self.assertTrue(chem.Atom('O') in mol)
        self.assertTrue(chem.Atom('S') in mol)
        self.assertFalse(chem.Atom('Lu') in mol)



if __name__ == '__main__':
    print('###############  This Friday at the "Chanipas", <Zug,Sadur> preforming live ################')
    unittest.main()

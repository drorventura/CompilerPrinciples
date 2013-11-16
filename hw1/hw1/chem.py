import pc

__author__ = 'Dror And Eldar'

periodicTable = {
    'H': {'name': 'Hydrogen', 'atomic_number': 1, 'atomic_weight': 1.00794},
    'He': {'name': 'Helium', 'atomic_number': 2, 'atomic_weight': 4.0026},
    'Li': {'name': 'Lithium', 'atomic_number': 3, 'atomic_weight': 6.941},
    'Be': {'name': 'Beryllium', 'atomic_number': 4, 'atomic_weight': 9.0122},
    'B': {'name': 'Boron', 'atomic_number': 5, 'atomic_weight': 10.811},
    'C': {'name': 'Carbon', 'atomic_number': 6, 'atomic_weight': 12.0107},
    'N': {'name': 'Nitrogen', 'atomic_number': 7, 'atomic_weight': 14.0067},
    'O': {'name': 'Oxygen', 'atomic_number': 8, 'atomic_weight': 15.9994},
    'F': {'name': 'Fluorine', 'atomic_number': 9, 'atomic_weight': 18.9984},
    'Ne': {'name': 'Neon', 'atomic_number': 10, 'atomic_weight': 20.1797},
    'Na': {'name': 'Sodium', 'atomic_number': 11, 'atomic_weight': 22.9897},
    'Mg': {'name': 'Magnesium', 'atomic_number': 12, 'atomic_weight': 24.305},
    'Al': {'name': 'Aluminum', 'atomic_number': 13, 'atomic_weight': 26.9815},
    'Si': {'name': 'Silicon', 'atomic_number': 14, 'atomic_weight': 28.0855},
    'P': {'name': 'Phosphorus', 'atomic_number': 15, 'atomic_weight': 30.9738},
    'S': {'name': 'Sulfur', 'atomic_number': 16, 'atomic_weight': 32.065},
    'Cl': {'name': 'Chlorine', 'atomic_number': 17, 'atomic_weight': 35.453},
    'Ar': {'name': 'Argon', 'atomic_number': 18, 'atomic_weight': 39.948},
    'K': {'name': 'Potassium', 'atomic_number': 19, 'atomic_weight': 39.0983},
    'Ca': {'name': 'Calcium', 'atomic_number': 20, 'atomic_weight': 40.078},
    'Sc': {'name': 'Scandium', 'atomic_number': 21, 'atomic_weight': 44.9559},
    'Ti': {'name': 'Titanium', 'atomic_number': 22, 'atomic_weight': 47.867},
    'V': {'name': 'Vanadium', 'atomic_number': 23, 'atomic_weight': 50.9415},
    'Cr': {'name': 'Chromium', 'atomic_number': 24, 'atomic_weight': 51.9961},
    'Mn': {'name': 'Manganese', 'atomic_number': 25, 'atomic_weight': 54.938},
    'Fe': {'name': 'Iron', 'atomic_number': 26, 'atomic_weight': 55.845},
    'Co': {'name': 'Cobalt', 'atomic_number': 27, 'atomic_weight': 58.9332},
    'Ni': {'name': 'Nickel', 'atomic_number': 28, 'atomic_weight': 58.6934},
    'Cu': {'name': 'Copper', 'atomic_number': 29, 'atomic_weight': 63.546},
    'Zn': {'name': 'Zinc', 'atomic_number': 30, 'atomic_weight': 65.39},
    'Ga': {'name': 'Gallium', 'atomic_number': 31, 'atomic_weight': 69.723},
    'Ge': {'name': 'Germanium', 'atomic_number': 32, 'atomic_weight': 72.64},
    'As': {'name': 'Arsenic', 'atomic_number': 33, 'atomic_weight': 74.9216},
    'Se': {'name': 'Selenium', 'atomic_number': 34, 'atomic_weight': 78.96},
    'Br': {'name': 'Bromine', 'atomic_number': 35, 'atomic_weight': 79.904},
    'Kr': {'name': 'Krypton', 'atomic_number': 36, 'atomic_weight': 83.8},
    'Rb': {'name': 'Rubidium', 'atomic_number': 37, 'atomic_weight': 85.4678},
    'Sr': {'name': 'Strontium', 'atomic_number': 38, 'atomic_weight': 87.62},
    'Y': {'name': 'Yttrium', 'atomic_number': 39, 'atomic_weight': 88.9059},
    'Zr': {'name': 'Zirconium', 'atomic_number': 40, 'atomic_weight': 91.224},
    'Nb': {'name': 'Niobium', 'atomic_number': 41, 'atomic_weight': 92.9064},
    'Mo': {'name': 'Molybdenum', 'atomic_number': 42, 'atomic_weight': 95.94},
    'Tc': {'name': 'Technetium', 'atomic_number': 43, 'atomic_weight': 98},
    'Ru': {'name': 'Ruthenium', 'atomic_number': 44, 'atomic_weight': 101.07},
    'Rh': {'name': 'Rhodium', 'atomic_number': 45, 'atomic_weight': 102.9055},
    'Pd': {'name': 'Palladium', 'atomic_number': 46, 'atomic_weight': 106.42},
    'Ag': {'name': 'Silver', 'atomic_number': 47, 'atomic_weight': 107.8682},
    'Cd': {'name': 'Cadmium', 'atomic_number': 48, 'atomic_weight': 112.411},
    'In': {'name': 'Indium', 'atomic_number': 49, 'atomic_weight': 114.818},
    'Sn': {'name': 'Tin', 'atomic_number': 50, 'atomic_weight': 118.71},
    'Sb': {'name': 'Antimony', 'atomic_number': 51, 'atomic_weight': 121.76},
    'Te': {'name': 'Tellurium', 'atomic_number': 52, 'atomic_weight': 127.6},
    'I': {'name': 'Iodine', 'atomic_number': 53, 'atomic_weight': 126.9045},
    'Xe': {'name': 'Xenon', 'atomic_number': 54, 'atomic_weight': 131.293},
    'Cs': {'name': 'Cesium', 'atomic_number': 55, 'atomic_weight': 132.9055},
    'Ba': {'name': 'Barium', 'atomic_number': 56, 'atomic_weight': 137.327},
    'La': {'name': 'Lanthanum', 'atomic_number': 57, 'atomic_weight': 138.9055},
    'Ce': {'name': 'Cerium', 'atomic_number': 58, 'atomic_weight': 140.116},
    'Pr': {'name': 'Praseodymium', 'atomic_number': 59, 'atomic_weight': 140.9077},
    'Nd': {'name': 'Neodymium', 'atomic_number': 60, 'atomic_weight': 144.24},
    'Pm': {'name': 'Promethium', 'atomic_number': 61, 'atomic_weight': 145},
    'Sm': {'name': 'Samarium', 'atomic_number': 62, 'atomic_weight': 150.36},
    'Eu': {'name': 'Europium', 'atomic_number': 63, 'atomic_weight': 151.964},
    'Gd': {'name': 'Gadolinium', 'atomic_number': 64, 'atomic_weight': 157.25},
    'Tb': {'name': 'Terbium', 'atomic_number': 65, 'atomic_weight': 158.9253},
    'Dy': {'name': 'Dysprosium', 'atomic_number': 66, 'atomic_weight': 162.5},
    'Ho': {'name': 'Holmium', 'atomic_number': 67, 'atomic_weight': 164.9303},
    'Er': {'name': 'Erbium', 'atomic_number': 68, 'atomic_weight': 167.259},
    'Tm': {'name': 'Thulium', 'atomic_number': 69, 'atomic_weight': 168.9342},
    'Yb': {'name': 'Ytterbium', 'atomic_number': 70, 'atomic_weight': 173.04},
    'Lu': {'name': 'Lutetium', 'atomic_number': 71, 'atomic_weight': 174.967},
    'Hf': {'name': 'Hafnium', 'atomic_number': 72, 'atomic_weight': 178.49},
    'Ta': {'name': 'Tantalum', 'atomic_number': 73, 'atomic_weight': 180.9479},
    'W': {'name': 'Tungsten', 'atomic_number': 74, 'atomic_weight': 183.84},
    'Re': {'name': 'Rhenium', 'atomic_number': 75, 'atomic_weight': 186.207},
    'Os': {'name': 'Osmium', 'atomic_number': 76, 'atomic_weight': 190.23},
    'Ir': {'name': 'Iridium', 'atomic_number': 77, 'atomic_weight': 192.217},
    'Pt': {'name': 'Platinum', 'atomic_number': 78, 'atomic_weight': 195.078},
    'Au': {'name': 'Gold', 'atomic_number': 79, 'atomic_weight': 196.9665},
    'Hg': {'name': 'Mercury', 'atomic_number': 80, 'atomic_weight': 200.59},
    'Tl': {'name': 'Thallium', 'atomic_number': 81, 'atomic_weight': 204.3833},
    'Pb': {'name': 'Lead', 'atomic_number': 82, 'atomic_weight': 207.2},
    'Bi': {'name': 'Bismuth', 'atomic_number': 83, 'atomic_weight': 208.9804},
    'Po': {'name': 'Polonium', 'atomic_number': 84, 'atomic_weight': 208.982},
    'At': {'name': 'Astatine', 'atomic_number': 85, 'atomic_weight': 209.987},
    'Rn': {'name': 'Radon', 'atomic_number': 86, 'atomic_weight': 222},
    'Fr': {'name': 'Francium', 'atomic_number': 87, 'atomic_weight': 223},
    'Ra': {'name': 'Radium', 'atomic_number': 88, 'atomic_weight': 226},
    'Ac': {'name': 'Actinium', 'atomic_number': 89, 'atomic_weight': 227},
    'Th': {'name': 'Thorium', 'atomic_number': 90, 'atomic_weight': 232.0381},
    'Pa': {'name': 'Protactinium', 'atomic_number': 91, 'atomic_weight': 231.0359},
    'U': {'name': 'Uranium', 'atomic_number': 92, 'atomic_weight': 238.0289},
    'Np': {'name': 'Neptunium', 'atomic_number': 93, 'atomic_weight': 237},
    'Pu': {'name': 'Plutonium', 'atomic_number': 94, 'atomic_weight': 244.064},
    'Am': {'name': 'Americium', 'atomic_number': 95, 'atomic_weight': 243.061},
    'Cm': {'name': 'Curium', 'atomic_number': 96, 'atomic_weight': 247},
    'Bk': {'name': 'Berkelium', 'atomic_number': 97, 'atomic_weight': 247},
    'Cf': {'name': 'Californium', 'atomic_number': 98, 'atomic_weight': 251},
    'Es': {'name': 'Einsteinium', 'atomic_number': 99, 'atomic_weight': 252},
    'Fm': {'name': 'Fermium', 'atomic_number': 100, 'atomic_weight': 257},
    'Md': {'name': 'Mendelevium', 'atomic_number': 101, 'atomic_weight': 258},
    'No': {'name': 'Nobelium', 'atomic_number': 102, 'atomic_weight': 259},
    'Lr': {'name': 'Lawrencium', 'atomic_number': 103, 'atomic_weight': 262},
    'Rf': {'name': 'Rutherfordium', 'atomic_number': 104, 'atomic_weight': 261},
    'Db': {'name': 'Dubnium', 'atomic_number': 105, 'atomic_weight': 262},
    'Sg': {'name': 'Seaborgium', 'atomic_number': 106, 'atomic_weight': 266},
    'Bh': {'name': 'Bohrium', 'atomic_number': 107, 'atomic_weight': 264},
    'Bh': {'name': 'Bohrium', 'atomic_number': 107, 'atomic_weight': 264},
    'Hs': {'name': 'Hassium', 'atomic_number': 108, 'atomic_weight': 277},
    'Mt': {'name': 'Meitnerium', 'atomic_number': 109, 'atomic_weight': 268},
    }

class NoSuchAtom(Exception):
    def __init__(self,symbol):
        Exception.__init__(self,'%s' % symbol)

class Chem:
    def __str__(self):
        return '%s' % self.accept(AsStringVisitor)

    def computeWeight(self):
        return self.accept(ComputeWeightVisitor)

    def __contains__(self, item):
        return self.acceptContains(ContainsVisitor,item)

    def atoms(self):
        return self.accept(AtomsVisitor)

    @staticmethod
    def parsingRules():
        ps = pc.ParserStack()

        D1 = ps.const(lambda x: x >= '1' and x <= '9' )\
               .done()

        D0 = ps.parser(D1)\
               .const(lambda x: x == '0')\
               .disj()\
               .done()

        Number = ps.parser(D1)\
                   .parser(D0)\
                   .star()\
                   .pack(lambda x: ''.join(x))\
                   .caten()\
                   .pack(lambda x: ''.join(x))\
                   .done()

        FirstLetter = ps.const(lambda x: x >= 'A' and x <= 'Z')\
                        .done()

        Letter = ps.const(lambda x: x >= 'a' and x <= 'z')\
                   .done()

        LeftBrackets = ps.const(lambda x: x == '[')\
                         .done()

        RightBrackets = ps.const(lambda x: x == ']')\
                          .done()

        LeftRoundBrackets = ps.const(lambda x: x == '(')\
                              .done()

        RightRoundBrackets = ps.const(lambda x: x == ')')\
                               .done()

        Any = ps.const(lambda x: x != '}' and x != '{')\
                .done()

        Comments1 = ps.parser(pc.pcChar('{'))\
                      .parser(Any)\
                      .star()\
                      .pack(lambda x: ''.join(x))\
                      .parser(pc.pcChar('}'))\
                      .catens(3)\
                      .pack(lambda x: ''.join(x))\
                      .parser(pc.pcChar('{'))\
                      .parser(Any)\
                      .star()\
                      .pack(lambda x: ''.join(x))\
                      .delayed_parser(lambda : Comments2)\
                      .catens(3)\
                      .pack(lambda x: ''.join(x))\
                      .disj()\
                      .done()

        Comments2 = ps.parser(Any)\
                      .star()\
                      .pack(lambda x: ''.join(x))\
                      .parser(pc.pcWord('}'))\
                      .caten()\
                      .pack(lambda x: x[1][0])\
                      .parser(Comments1)\
                      .parser(Any)\
                      .star()\
                      .pack(lambda x: ''.join(x))\
                      .delayed_parser(lambda: Comments2)\
                      .catens(3)\
                      .pack(lambda x: ''.join(x))\
                      .disj()\
                      .done()\

        AtomRule = ps.parser(FirstLetter)\
                     .parser(pc.pcWhite1)\
                     .parser(Comments1)\
                     .disj()\
                     .star()\
                     .pack(lambda x: ''.join(x))\
                     .parser(Letter)\
                     .star()\
                     .pack(lambda x: ''.join(x))\
                     .pack(lambda x: x.replace(' ',''))\
                     .parser(pc.pcWhite1)\
                     .parser(Comments1)\
                     .disj()\
                     .star()\
                     .pack(lambda x: ''.join(x))\
                     .pack(lambda x: x.replace(' ','')) \
                     .catens(4)\
                     .pack(lambda x: (x[0],x[2]))\
                     .pack(lambda x: ''.join(x))\
                     .parser(FirstLetter)\
                     .parser(pc.pcWhite1)\
                     .parser(Comments1)\
                     .disj()\
                     .star()\
                     .pack(lambda x: ''.join(x))\
                     .pack(lambda x: x.replace(' ',''))\
                     .caten()\
                     .pack(lambda x: x[0])\
                     .disj()\
                     .pack(lambda x: Atom(x))\
                     .done()

        MultiRule = ps.parser(AtomRule)\
                      .parser(Number)\
                      .parser(pc.pcWhite1)\
                      .parser(Comments1)\
                      .disj()\
                      .star()\
                      .catens(3) \
                      .parser(LeftRoundBrackets) \
                      .delayed_parser(lambda: MolRules1) \
                      .parser(RightRoundBrackets) \
                      .parser(Number) \
                      .parser(pc.pcWhite1) \
                      .parser(Comments1) \
                      .disj() \
                      .star() \
                      .catens(5) \
                      .pack(lambda x: (x[1],x[3]))\
                      .parser(LeftBrackets) \
                      .delayed_parser(lambda: MolRules1) \
                      .parser(RightBrackets) \
                      .parser(Number) \
                      .parser(pc.pcWhite1) \
                      .parser(Comments1) \
                      .disj() \
                      .star() \
                      .catens(5) \
                      .pack(lambda x: (x[1],x[3]))\
                      .disjs(3) \
                      .pack(lambda x: Multiplicity(x[0],x[1]))\
                      .done()

        GroupRule = ps.parser(MultiRule)\
                      .delayed_parser(lambda: MolRules1)\
                      .caten()\
                      .parser(AtomRule)\
                      .delayed_parser(lambda: MolRules1)\
                      .caten() \
                      .parser(LeftBrackets)\
                      .delayed_parser(lambda : MolRules1)\
                      .parser(RightBrackets)\
                      .delayed_parser(lambda : MolRules1)\
                      .catens(4)\
                      .pack(lambda x: (x[1],x[3]))\
                      .parser(LeftRoundBrackets)\
                      .delayed_parser(lambda : MolRules1)\
                      .parser(RightRoundBrackets)\
                      .delayed_parser(lambda : MolRules1)\
                      .catens(4)\
                      .pack(lambda x: (x[1],x[3]))\
                      .disjs(4) \
                      .pack(lambda x: Group(x[0],x[1]))\
                      .done()

        MolRules1 = ps.parser(GroupRule) \
                      .parser(MultiRule) \
                      .parser(AtomRule) \
                      .parser(LeftRoundBrackets) \
                      .delayed_parser(lambda :MolRules2)\
                      .parser(RightRoundBrackets) \
                      .catens(3) \
                      .pack(lambda x: x[1])\
                      .parser(LeftBrackets) \
                      .delayed_parser(lambda :MolRules2) \
                      .parser(RightBrackets) \
                      .catens(3) \
                      .pack(lambda x: x[1])\
                      .parser(Comments1)\
                      .parser(pc.pcWhite1)\
                      .disj()\
                      .delayed_parser(lambda :MolRules2) \
                      .caten() \
                      .pack(lambda x: x[1])\
                      .disjs(6) \
                      .done()

        MolRules2 = ps.parser(MolRules1)\
                      .parser(Comments1)\
                      .parser(pc.pcWhite1)\
                      .disj()\
                      .star()\
                      .pack(lambda x: ''.join(x))\
                      .caten()\
                      .pack(lambda x: x[0])\
                      .done()\

        MoleculeRule = ps.parser(MolRules1)\
                         .pack(lambda x: Molecule(x))\
                         .done()

        return MoleculeRule

    @staticmethod
    def readMoleculeFromString(string):
        mol, remaining = Chem.parsingRules().match(string)

        return mol , remaining

class Atom(Chem):
    def __init__(self,symbol):
        if symbol in periodicTable:
            self.symbol = symbol
            self.name = periodicTable.get(symbol).get('name')
            self.weight = periodicTable.get(symbol).get('atomic_weight')
            self.number = periodicTable.get(symbol).get('atomic_number')
        else:
            raise NoSuchAtom(symbol)

    def accept(self,visitor):
        return visitor.visitAtom(self)

    def acceptContains(self,visitor,item):
        return visitor.visitAtom(self,item)

class Group(Chem):
    def __init__(self,mol1,mol2):
        self.mol1 = mol1
        self.mol2 = mol2

    def accept(self,visitor):
        return visitor.visitGroup(self)

    def acceptContains(self,visitor,item):
        return visitor.visitGroup(self,item)

class Multiplicity(Chem):
    def __init__(self,mol,number):
        self.mol = mol
        self.number = number

    def accept(self,visitor):
        return visitor.visitMultiplicity(self)

    def acceptContains(self,visitor,item):
        return visitor.visitMultiplicity(self,item)

class Molecule(Chem):
    def __init__(self,mol):
        self.mol = mol

    def accept(self,visitor):
        return visitor.visitMolecule(self)

    def acceptContains(self,visitor,item):
        return visitor.visitMolecule(self,item)

class AbstractChemVisitor:
    def foo(self):
        print("just a stupid function")

class AtomsVisitor(AbstractChemVisitor):
    def visitAtom(self):
        return set([self])

    def visitGroup(self):
        return self.mol1.atoms()^self.mol2.atoms()

    def visitMultiplicity(self):
        return self.mol.atoms()

    def visitMolecule(self):
        return self.mol.atoms()

class ContainsVisitor(AbstractChemVisitor):
    def visitAtom(self,item):
        return self.symbol == item.symbol

    def visitGroup(self,item):
        return self.mol1.__contains__(item) or self.mol2.__contains__(item)

    def visitMultiplicity(self,item):
        return self.mol.__contains__(item)

    def visitMolecule(self,item):
        return self.mol.__contains__(item)

class ComputeWeightVisitor(AbstractChemVisitor):
    def visitAtom(self):
        return self.weight

    def visitGroup(self):
        return self.mol1.computeWeight() + self.mol2.computeWeight()

    def visitMultiplicity(self):
        return float(self.number) * self.mol.computeWeight()

    def visitMolecule(self):
        return self.mol.computeWeight()

class AsStringVisitor(AbstractChemVisitor):
    def visitAtom(self):
        return '%s' % self.symbol

    def visitGroup(self):
        return '%s' % self.mol1 + '%s' % self.mol2

    def visitMultiplicity(self):
        if type(self.mol) == Atom:
            return '%s' % self.mol + '%s' % self.number
        else:
            return '(%s)' % self.mol + '%s' % self.number

    def visitMolecule(self):
        return '%s' % self.mol


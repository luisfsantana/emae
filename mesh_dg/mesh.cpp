//
//////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2012 Autodesk, Inc.  All rights reserved.
//
// Mafes inteligencia agricola
//
//////////////////////////////////////////////////////////////////////////////
//
// mesh.cpp

#if defined(_DEBUG) && !defined(AC_FULL_DEBUG)
#error _DEBUG should not be defined except in internal Adesk debug builds
#endif

#include "aced.h"
#include "dbsymtb.h"
#include "dbapserv.h"
#include "acgi.h"
#include "tchar.h"


// Helpful Color constants for setting attributes:
//Cores
static const Adesk::UInt16 kColorByBlock   = 0;
static const Adesk::UInt16 kRed            = 1;
static const Adesk::UInt16 kYellow         = 2;
static const Adesk::UInt16 kGreen          = 3;
static const Adesk::UInt16 kCyan           = 4;
static const Adesk::UInt16 kBlue           = 5;
static const Adesk::UInt16 kMagenta        = 6;
static const Adesk::UInt16 kWhite          = 7;
static const Adesk::UInt16 kColorByLayer   = 256;


class AsdkMeshSamp: public AcDbEntity
{
public:
    ACRX_DECLARE_MEMBERS(AsdkMeshSamp);
    AsdkMeshSamp(); //Construtor
    ~AsdkMeshSamp(); //Destrutor
protected:
    virtual Adesk::Boolean  subWorldDraw(AcGiWorldDraw *);         //Funcao Desenha
    Acad::ErrorStatus       subTransformBy(const AcGeMatrix3d &);  //
};

ACRX_DXF_DEFINE_MEMBERS(AsdkMeshSamp, AcDbEntity, 
AcDb::kDHL_CURRENT, AcDb::kMReleaseCurrent, 0,\
    ASDKMESHSAMP, AcGiMesh Sample);

//Implementacao do construtor
AsdkMeshSamp::AsdkMeshSamp()
{}

//Implementacao do destrutor
AsdkMeshSamp::~AsdkMeshSamp()
{}

//Estato de erro
Acad::ErrorStatus
AsdkMeshSamp::subTransformBy(const AcGeMatrix3d &xfm)
{
    return Acad::eOk;
}
/*
//Funcao Desenha
// THE FOLLOWING CODE APPEARS IN THE SDK DOCUMENT.
Adesk::Boolean
AsdkMeshSamp::subWorldDraw(AcGiWorldDraw* pW)
{
    Adesk::UInt32 i, j, k;
    Adesk::UInt32 numRows = 3;
    Adesk::UInt32 numCols = 2;
    AcGePoint3d *pVerts = new AcGePoint3d[numRows * numCols]; //pVerts tem 16 posicoes

	Polyline* pL= new Polyline();

	//Definicao de todos os pontos x,y
    for (k = 0, i = 0; i < numRows; i++) {
        for (j = 0; j < numCols; j++, k++) {
			pVerts[k].x = (double)j*2;
            pVerts[k].y = (double)i;
            pVerts[k].z = 0.;
        }
    }

    // Construct an array of colors to be applied to each
    // edge of the mesh.  Here, let the rows be cyan and
    // the columns be green.
    AcGiEdgeData edgeInfo;
    Adesk::UInt32 numRowEdges = numRows * (numCols - 1); //12
    Adesk::UInt32 numColEdges = (numRows - 1) * numCols; //12
    Adesk::UInt32 numEdges = numRowEdges + numColEdges;  //24
    short *pEdgeColorArray = new short[numEdges];        //24 posicoes
    
    for (i = 0; i < numEdges; i++) {
        pEdgeColorArray[i] = i < numRowEdges ? kCyan : kGreen;
    }
	edgeInfo.setColors(pEdgeColorArray);

    // Make the first face transparent and the rest
    // different colors.
    Adesk::UInt32 numFaces = (numRows - 1) * (numCols - 1); //9 faces

    Adesk::UInt8 *pFaceVisArray = new Adesk::UInt8[numFaces]; //array 9 faces
    
	short *pFaceColorArray = new short[numFaces]; //array de cores com 9 posicoes

    AcGiFaceData faceInfo;
    faceInfo.setVisibility(pFaceVisArray);

    for (i = 0; i < numFaces; i++) {
        pFaceVisArray[i] = i ? kAcGiVisible : kAcGiInvisible;
        pFaceColorArray[i] = (short)(i + 1);
    }
	pFaceVisArray[1] = kAcGiInvisible;
    pFaceColorArray[1] = (short)(1);
    
	faceInfo.setColors(pFaceColorArray);

    // If the fill type is kAcGiFillAlways, then a shell,
    // mesh, or polygon will be interpreted as faces;
    // otherwise, they will be interpreted as edges.

    // Output mesh as faces.
    pW->subEntityTraits().setFillType(kAcGiFillAlways);

    pW->geometry().mesh(numRows, numCols, pVerts, NULL, &faceInfo);

    // Output mesh as edges over the faces.
    pW->subEntityTraits().setFillType(kAcGiFillNever);
    pW->geometry().mesh(numRows, numCols, pVerts, &edgeInfo);

    delete [] pVerts;
    delete [] pEdgeColorArray;
    delete [] pFaceColorArray;
    delete [] pFaceVisArray;
 
    return Adesk::kTrue;
}
*/
// END CODE APPEARING IN SDK DOCUMENT.
static void deleteArray(AcDbVoidPtrArray entities)
{
    AcDbEntity* pEnt;
    int nEnts;
 
    nEnts = entities.length();
    for(int i = 0; i < nEnts; i++)
    {
        pEnt = (AcDbEntity*)(entities[i]);
        delete pEnt;
    }
}
 
static void appendEntity(
                            AcDbEntity* pEnt,
                            AcDbObjectId recordId
                        )
{
    AcDbBlockTableRecord* pRecord;
    acdbOpenObject(pRecord, recordId, AcDb::kForWrite);
    pRecord->appendAcDbEntity(pEnt);
    pRecord->close();
}

static void ADSProject_Test_Offset(void)
{
    AcDbPolyline *pPolyEnt = NULL; 
    AcDbEntity *pObj;
    AcDbPolyline *pPolyPositive = NULL; //vetor
    AcDbObjectId polyEntId, ownerId;
    AcDbVoidPtrArray ar_polyPositives;
    
    ads_real offset = 24.0;
    ads_name eName;
    ads_point pt;
    int rc;
   
		rc = acedEntSel( ACRX_T("\nSelect Polyline to offset "),
						 eName,
						 pt);

  		// Get the selected entity object ID
		acdbGetObjectId(polyEntId, eName);
 
		// Is the selected entity an AcDbPolyline
		acdbOpenObject(pObj, polyEntId, AcDb::kForRead);
		if(pObj == NULL)
		{
			acutPrintf(_T("\nObjeto pObj vazio no Offset "));
			return;
		}
 
		pPolyEnt = AcDbPolyline::cast(pObj);
		if(!pPolyEnt)
		{
			acutPrintf(_T("\nNao eh AcDbPolyline entity "));
			pPolyEnt->close();
			return;
		}	

		try
		{
			// who owns the polyline Model Space or Paper Space
			ownerId = pPolyEnt->ownerId();
			pPolyEnt->getOffsetCurves(offset, ar_polyPositives); //Offset
		
			if(ar_polyPositives.length() != 1)
			{
				deleteArray(ar_polyPositives);
				pPolyEnt->close();
				return;
			}
			else
			{
				pPolyPositive = (AcDbPolyline*)(ar_polyPositives[0]);
				appendEntity(pPolyPositive, ownerId);
			}
 			
		}
		catch(...)
		{
			acutPrintf(ACRX_T("Desculpe, Erro enquanto offsetting."));
		}
 
		pPolyEnt->close();
 
		if(pPolyPositive)
		{
			pPolyPositive->close();
		}
		acutPrintf(_T("\nExecutou o primeiro offset "));
}
 

static void MessageLine(void)
{
	ads_name eName;
    ads_point pt;
    int rc;
	rc = acedEntSel( ACRX_T("\nSelect Polyline to offset "),
						 eName,
						 pt);
	if(rc==5100){
		acutPrintf(_T("\nMessage Line: Select Polyline correct "));		
	}else{
	acutPrintf(_T("\nMessage Line: Select Polyline INcorrect"));
	}
}


static void MontaLinhas(void)
{
	
	AcDbPolyline* pB = new AcDbPolyline();
	pB->addVertexAt(0, AcGePoint2d(-5.4666, 5.0685), 0.1, -1, -1, 0);
	pB->addVertexAt(1, AcGePoint2d(28.6631, 3.9422), 0.1, -1, -1, 0);
	
	//OK
	//AcDbPolyline* pC = new AcDbPolyline(); 
	//pC->addVertexAt(0, AcGePoint2d(3.3772, -1.5093),  0.425, -1, -1, 0);
	//pC->addVertexAt(1, AcGePoint2d(15.5614, -3.2455),  0.425, -1, -1, 0);
	

	//AcDbPolyline* pD = new AcDbPolyline();
	//pD->addVertexAt(0, AcGePoint2d(0.6158, -0.6029),  0.69, -1, -1, 0);
	//pD->addVertexAt(1, AcGePoint2d(20.1709, -0.0280),  0.69, -1, -1, 0);

	//AcDbPolyline* pE = new AcDbPolyline();
	//pE->addVertexAt(0, AcGePoint2d(-1.8367, 0.5266), 0.818, -1, -1, 0);
	//pE->addVertexAt(1, AcGePoint2d(22.5521, 1.2393), 0.818, -1, -1, 0);

	//AcDbPolyline* pF = new AcDbPolyline();
	//pF->addVertexAt(0, AcGePoint2d(-4.1552, 2.9266), 0.909, -1, -1, 0);
	//pF->addVertexAt(1, AcGePoint2d(24.5593, 1.1209), 0.909, -1, -1, 0);

	//AcDbPolyline* pG = new AcDbPolyline();
	//pG->addVertexAt(0, AcGePoint2d(-5.7994, -0.0807), 0.82, -1, -1, 0);
	//pG->addVertexAt(1, AcGePoint2d(26.4853, 0.5103), 0.82, -1, -1, 0);

	//AcDbPolyline* pH = new AcDbPolyline();
	//pH->addVertexAt(0, AcGePoint2d(-7.0134, -3.0547), 0.75, -1, -1, 0);
	//pH->addVertexAt(1, AcGePoint2d(28.4866, -0.3491), 0.57, -1, -1, 0);


	//AcDbPolyline* pI = new AcDbPolyline();
	//pI->addVertexAt(0, AcGePoint2d(-7.8740, -6.0459), 0.629, -1, -1, 0);
	//pI->addVertexAt(1, AcGePoint2d(28.9231, -5.0582), 0.629, -1, -1, 0);

	// Abre o container apropriado	
	AcDbBlockTable* pBT = NULL;
	AcDbDatabase* pDB = acdbHostApplicationServices()->workingDatabase();
	pDB->getSymbolTable(pBT,AcDb::kForRead);
	AcDbBlockTableRecord* pBTR = NULL;
	pBT->getAt(ACDB_MODEL_SPACE, pBTR, AcDb::kForWrite);
	pBT->close();

	// Agora adiciona a entidade ao container
	//AcDbObjectId Id1;
	AcDbObjectId Id2;
	//AcDbObjectId Id3;
	//AcDbObjectId Id4;
	//AcDbObjectId Id5;
	//AcDbObjectId Id6;
	//AcDbObjectId Id7;
	//AcDbObjectId Id8;
	//AcDbObjectId Id9;
	
	AcCmColor m_Cor_green;
	m_Cor_green.setRGB(0, 255, 0); //Verde

	AcCmColor m_Cor_blue;
	m_Cor_blue.setRGB(15, 0, 255);


	//Set the Colors
	
	pB->setColor(m_Cor_blue, 1);
	//pC->setColor(m_Cor_green, 1);
	//pD->setColor(m_Cor_green, 1);
	//pE->setColor(m_Cor_green, 1);
	//pF->setColor(m_Cor_green, 1);
	//pG->setColor(m_Cor_green, 1);
	//pH->setColor(m_Cor_green, 1);
	//pI->setColor(m_Cor_green, 1);

	pBTR->appendAcDbEntity(Id2, pB);
	//pBTR->appendAcDbEntity(Id3, pC);
	//pBTR->appendAcDbEntity(Id4, pD);
	//pBTR->appendAcDbEntity(Id5, pE);
	//pBTR->appendAcDbEntity(Id6, pF);
	//pBTR->appendAcDbEntity(Id7, pG);
	//pBTR->appendAcDbEntity(Id8, pH);
	//pBTR->appendAcDbEntity(Id9, pI);
	
	pBTR->close();
	
	pB->close();
	//pC->close();
	//pD->close();
	//pE->close();
	//pF->close();
	//pG->close();
	//pH->close();
	//pI->close();
	
	

}


//Desenha 
Adesk::Boolean
AsdkMeshSamp::subWorldDraw(AcGiWorldDraw* mode)
{
	MessageLine();
	MontaLinhas();
	AcDbPolyline* pB = new AcDbPolyline();
	pB->addVertexAt(0, AcGePoint2d(7.5896, -2.5049), 0.1, -1, -1, 0);
	pB->addVertexAt(1, AcGePoint2d(10.0744, -3.0922), 0.1, -1, -1, 0);
	
	//OK
	AcDbPolyline* pC = new AcDbPolyline(); 
	pC->addVertexAt(0, AcGePoint2d(3.3772, -1.5093),  0.425, -1, -1, 0);
	pC->addVertexAt(1, AcGePoint2d(15.5614, -3.2455),  0.425, -1, -1, 0);
	

	AcDbPolyline* pD = new AcDbPolyline();
	pD->addVertexAt(0, AcGePoint2d(0.6158, -0.6029),  0.69, -1, -1, 0);
	pD->addVertexAt(1, AcGePoint2d(20.1709, -0.0280),  0.69, -1, -1, 0);

	AcDbPolyline* pE = new AcDbPolyline();
	pE->addVertexAt(0, AcGePoint2d(-1.8367, 0.5266), 0.818, -1, -1, 0);
	pE->addVertexAt(1, AcGePoint2d(22.5521, 1.2393), 0.818, -1, -1, 0);

	AcDbPolyline* pF = new AcDbPolyline();
	pF->addVertexAt(0, AcGePoint2d(-4.1552, 2.9266), 0.909, -1, -1, 0);
	pF->addVertexAt(1, AcGePoint2d(24.5593, 1.1209), 0.909, -1, -1, 0);

	AcDbPolyline* pG = new AcDbPolyline();
	pG->addVertexAt(0, AcGePoint2d(-5.7994, -0.0807), 0.82, -1, -1, 0);
	pG->addVertexAt(1, AcGePoint2d(26.4853, 0.5103), 0.82, -1, -1, 0);

	AcDbPolyline* pH = new AcDbPolyline();
	pH->addVertexAt(0, AcGePoint2d(-7.0134, -3.0547), 0.75, -1, -1, 0);
	pH->addVertexAt(1, AcGePoint2d(28.4866, -0.3491), 0.57, -1, -1, 0);


	AcDbPolyline* pI = new AcDbPolyline();
	pI->addVertexAt(0, AcGePoint2d(-7.8740, -6.0459), 0.629, -1, -1, 0);
	pI->addVertexAt(1, AcGePoint2d(28.9231, -5.0582), 0.629, -1, -1, 0);

	//AcDbPolyline* pJ = new AcDbPolyline();
	//pJ->addVertexAt(0, AcGePoint2d(-4.4215, 2.4922), 0.1, -1, -1, 0);
	//pJ->addVertexAt(1, AcGePoint2d(11.4734, -3.4177), 0.1, -1, -1, 0);


	//AcDbPolyline* pK = new AcDbPolyline();
	//pK->addVertexAt(0, AcGePoint2d(18.8570, -1.4346), 0.1, -1, -1, 0);
	//pK->addVertexAt(1, AcGePoint2d(23.0752, 1.2990), 0.1, -1, -1, 0);


	// Abre o container apropriado	
	AcDbBlockTable* pBT = NULL;
	AcDbDatabase* pDB = acdbHostApplicationServices()->workingDatabase();
	pDB->getSymbolTable(pBT,AcDb::kForRead);
	AcDbBlockTableRecord* pBTR = NULL;
	pBT->getAt(ACDB_MODEL_SPACE, pBTR, AcDb::kForWrite);
	pBT->close();

	// Agora adiciona a entidade ao container
	AcDbObjectId Id1;
	AcDbObjectId Id2;
	AcDbObjectId Id3;
	AcDbObjectId Id4;
	AcDbObjectId Id5;
	AcDbObjectId Id6;
	AcDbObjectId Id7;
	AcDbObjectId Id8;
	AcDbObjectId Id9;
	//AcDbObjectId Id10;
	//AcDbObjectId Id11;
	
	AcCmColor m_Cor_green;
	m_Cor_green.setRGB(0, 255, 0); //Verde

	AcCmColor m_Cor_blue;
	m_Cor_blue.setRGB(15, 0, 255);


	//Set the Colors
	//pA->setColor(m_Cor_red, 1);
	pB->setColor(m_Cor_blue, 1);
	pC->setColor(m_Cor_green, 1);
	pD->setColor(m_Cor_green, 1);
	pE->setColor(m_Cor_green, 1);
	pF->setColor(m_Cor_green, 1);
	pG->setColor(m_Cor_green, 1);
	pH->setColor(m_Cor_green, 1);
	pI->setColor(m_Cor_green, 1);
	//pJ->setColor(m_Cor_green, 1);
	//pK->setColor(m_Cor_green, 1);

	pBTR->appendAcDbEntity(Id2, pB);
	pBTR->appendAcDbEntity(Id3, pC);
	pBTR->appendAcDbEntity(Id4, pD);
	pBTR->appendAcDbEntity(Id5, pE);
	pBTR->appendAcDbEntity(Id6, pF);
	pBTR->appendAcDbEntity(Id7, pG);
	pBTR->appendAcDbEntity(Id8, pH);
	pBTR->appendAcDbEntity(Id9, pI);
	//pBTR->appendAcDbEntity(Id10, pJ);
	//pBTR->appendAcDbEntity(Id11, pK);

	pBTR->close();
	
	pB->close();
	pC->close();
	pD->close();
	pE->close();
	pF->close();
	pG->close();
	pH->close();
	pI->close();
	//pJ->close();
	//pK->close();
	//--ADSProject_Test_Offset();
	

	//------ Returning Adesk::kFalse here will force viewportDraw() call
	 return (Adesk::kTrue);
}


static void
addAsdkMeshSampObject()
{
    Acad::ErrorStatus es;
    AcDbBlockTable   *pBlockTable;
    es = acdbHostApplicationServices()->workingDatabase()
        ->getSymbolTable(pBlockTable, AcDb::kForRead);
    if (es != Acad::eOk)
        return;

    AcDbBlockTableRecord *pBlock;
    es = pBlockTable->getAt(ACDB_MODEL_SPACE, pBlock,
        AcDb::kForWrite);
    if (es != Acad::eOk)
        return;

    AcDbObjectId  objId;
    AsdkMeshSamp *pNewObj = new AsdkMeshSamp;
    es = pBlock->appendAcDbEntity(objId, pNewObj);
    if (es != Acad::eOk) {
        delete pNewObj;
        return;
    }

    es = pBlock->close();
    if (es != Acad::eOk)
        acrx_abort(_T("\nUnable to close block table record"));

    es = pBlockTable->close();
    if (es != Acad::eOk) 
        acrx_abort(_T("\nUnable to close block table"));

    es = pNewObj->close();
    if (es != Acad::eOk) 
        acrx_abort(_T("\nUnable to close new entity"));
}

static void
initAsdkMeshSamp()
{
    AsdkMeshSamp::rxInit();
    acrxBuildClassHierarchy();

    acedRegCmds->addCommand(_T("ACGI_MESH_SAMP"),
                            _T("ASDKMAKEMESH"),
                            _T("MAKEMESH"),
                            ACRX_CMD_TRANSPARENT,
                            addAsdkMeshSampObject);
}

extern "C" AcRx::AppRetCode
acrxEntryPoint(AcRx::AppMsgCode msg, void* appId) 
{
    switch (msg) {
	case AcRx::kInitAppMsg:
        acrxDynamicLinker->unlockApplication(appId);
		acrxDynamicLinker->registerAppMDIAware(appId);
        initAsdkMeshSamp();
	    break;
	case AcRx::kUnloadAppMsg:
	    acedRegCmds->removeGroup(_T("ACGI_MESH_SAMP"));
            deleteAcRxClass(AsdkMeshSamp::desc());
    }
    return AcRx::kRetOK;
}




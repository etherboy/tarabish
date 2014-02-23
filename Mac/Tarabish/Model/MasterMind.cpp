/*
 *  MasterMind.cpp
 *  Tarabish
 *
 *  Created by Fritz Vander Heide on 11/11/07.
 *  Copyright 2007 Grimlock Tech. All rights reserved.
 *
 */

#include "MasterMind.h"
#include <iostream>
#include "Deck.h"

TTrumpRuleCollection CMasterMind::s_nTrumpRules;

TTrumpRuleCollection& CMasterMind::MutableTrumpRules()
{
	return s_nTrumpRules;
}

CMasterMind::CMasterMind()
{
	
}

CMasterMind::~CMasterMind()
{
	
}

TCardSuit CMasterMind::CallTrump(CPlayer* pPlayer, bool bForced) const
{	
	struct SSuitStats
	{
		int iCardCount;
		std::string szCardRanks;
		int iValue;
		int iTrumpValue;
		
		SSuitStats() : iCardCount(0), iValue(0), iTrumpValue(0)
		{
		}
	};
	
	const TCardList& nHand = pPlayer->Hand();
	
//	TCardList nHand;
//	nHand.push_back(&CDeck::SharedDeck()[(DIAMOND-1)*9 + EIGHT - 4]);
//	nHand.push_back(&CDeck::SharedDeck()[(HEART-1)*9 + JACK - 4]);
//	nHand.push_back(&CDeck::SharedDeck()[(CLUB-1)*9 + NINE - 4]);
//	nHand.push_back(&CDeck::SharedDeck()[(CLUB-1)*9 + JACK - 4]);
//	nHand.push_back(&CDeck::SharedDeck()[(CLUB-1)*9 + QUEEN - 4]);
//	nHand.push_back(&CDeck::SharedDeck()[(CLUB-1)*9 + KING - 4]);
	
	SSuitStats nSuitStatistics[4];
	
	int iSize = nHand.size();
	
	for(int i = iSize - 1; i >= 0; --i)
	{
		int iSuitIndex = static_cast<int>(nHand[i]->Suit()) - 1;
		
		++nSuitStatistics[iSuitIndex].iCardCount;
		nSuitStatistics[iSuitIndex].szCardRanks += nHand[i]->Description(true)[0];
		nSuitStatistics[iSuitIndex].iValue += nHand[i]->Value();
		nSuitStatistics[iSuitIndex].iTrumpValue += nHand[i]->Value(true);
	}
	
	int iRuleMatched[4] = {-1, -1, -1, -1};
	
	for(int i = 0; i < 4; ++i)
	{
		int iOutsidePoints = 0;
	
		for(int j = 0; j < 4; ++j)
		{
			if(j != i)
			{
				iOutsidePoints += nSuitStatistics[j].iValue;
			}
		}
		
		int iRuleCount = s_nTrumpRules.size();
		
		for(int k = 0; (iRuleMatched[i] == -1) && (k < iRuleCount); ++k)
		{
			bool bAllReqFound = true;
			int iReqTrumpCount = s_nTrumpRules[k].szRequiredTrump.length();
			for(int q = 0; q < iReqTrumpCount; ++q)
			{
				if(nSuitStatistics[i].szCardRanks.find(s_nTrumpRules[k].szRequiredTrump[q]) == std::string::npos)
				{
					bAllReqFound = false;
				}
			}
			
			if(bAllReqFound)
			{
				if(nSuitStatistics[i].iCardCount >= (s_nTrumpRules[k].iAdditionalTrump + iReqTrumpCount))
				{
					if(iOutsidePoints >= s_nTrumpRules[k].iTotalOutsidePoints)
					{
						bool bPrimaryMatches[4] = {false, false, false, false};
						bool bSecondaryMatches[4] = {false, false, false, false};
							
						for(int m = 0; (iRuleMatched[i]== -1) && (m < 4); ++m)
						{
							if(m != i)
							{
								bool bAllReqFound = true;
								int iReqPrimaryCount = s_nTrumpRules[k].szRequiredPrimaryOutside.length();
								for(int q = 0; q < iReqPrimaryCount; ++q)
								{
									if(nSuitStatistics[m].szCardRanks.find(s_nTrumpRules[k].szRequiredPrimaryOutside[q]) == std::string::npos)
									{
										bAllReqFound = false;
									}
								}
								
								if(bAllReqFound)
								{
									if(nSuitStatistics[m].iCardCount >= (s_nTrumpRules[k].iAdditionalPrimaryOutside + iReqPrimaryCount))
									{
										bPrimaryMatches[m] = true;
									}
								}
								
								bAllReqFound = true;
								int iReqSecondaryCount = s_nTrumpRules[k].szRequiredSecondaryOutside.length();
								for(int q = 0; q < iReqSecondaryCount; ++q)
								{
									if(nSuitStatistics[m].szCardRanks.find(s_nTrumpRules[k].szRequiredSecondaryOutside[q]) == std::string::npos)
									{
										bAllReqFound = false;
									}
								}
									
								if(bAllReqFound)
								{
									bSecondaryMatches[m] = true;
								}
							}
						}
						
						for(int n = 0; (iRuleMatched[i] == -1) && (n < 4); ++n)
						{
							for(int o = 0; (iRuleMatched[i] == -1) && (o < 4); ++o)
							{
								if(n != o)
								{
									if(bPrimaryMatches[n] && bSecondaryMatches[o])
									{
										iRuleMatched[i] = k;
									}
								}
							}
						}
					}
				}
			}
		}
	}
	
	std::pair<int,int> aBestTrumpSuit(0,25);
	int iSuitWithMostCards = 0;
	
	for(int i = 0; i < 4; ++i)
	{
		if((iRuleMatched[i] < aBestTrumpSuit.second) && (iRuleMatched[i] > -1))
		{
			aBestTrumpSuit.first = i+1;
			aBestTrumpSuit.second = iRuleMatched[i];
		}
		
		if(nSuitStatistics[i].iCardCount > nSuitStatistics[iSuitWithMostCards].iCardCount)
		{
			iSuitWithMostCards = i;
		}
	}
	
	if((aBestTrumpSuit.first == 0) && bForced)
	{
		aBestTrumpSuit.first = iSuitWithMostCards + 1; 
	}
	
	return static_cast<TCardSuit>(aBestTrumpSuit.first); 
}

TCardList CMasterMind::FindBella(const TCardList& nHand, TCardSuit eTrump) const
{
	TCardList nBella;
	
	int iLastIndex = nHand.size() - 1;
	
	for(int i = iLastIndex; i > 0; i--)
	{
		if((nHand[i-1]->Suit() == eTrump) && (nHand[i]->Suit() == eTrump))
		{
			if((nHand[i-1]->Rank() == QUEEN) && (nHand[i]->Rank() == KING))
			{
				nBella.push_back(nHand[i-1]);
				nBella.push_back(nHand[i]);
				break;
			}
		}
	}
	
	return nBella;
}

void PrintCards(const TCardList& nCards)
{
	std::cout << nCards << std::endl;
}

std::vector<TCardList> CMasterMind::FindRuns(const TCardList& nHand) const
{
	std::vector<TCardList> nRunList;
	TCardList nCurrentRun;
	
	for(int i = nHand.size() - 1; i >= 0; i--)
	{
		if(nCurrentRun.empty())
		{
			nCurrentRun.push_back(nHand[i]);
			continue;
		}
		
		bool bFinishedRun = true;
		
		
		if((nCurrentRun.back()->Suit() == nHand[i]->Suit()) && (nCurrentRun.back()->Rank() - nHand[i]->Rank() == 1))
		{
			nCurrentRun.push_back(nHand[i]);
			
			if((nCurrentRun.size() < 4) && (i > 0))
			{
				bFinishedRun = false;
			}
		} 
		
		if(bFinishedRun)
		{
			if((nCurrentRun.back() != nHand[i]) && (i > 0))
			{
				++i;
			}
			
			if(nCurrentRun.size() >= 3)
			{
				std::reverse(nCurrentRun.begin(), nCurrentRun.end());
				nRunList.push_back(nCurrentRun);
			}
			
			nCurrentRun.clear();
		}
	}
	
	return nRunList;
}



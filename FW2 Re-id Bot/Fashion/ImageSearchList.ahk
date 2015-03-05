ImageSearchList(p_ImgStr,p_StartX=0,p_StartY=0,p_EndX=0,p_EndY=0,p_CDelim=",",p_LDelim="`n",p_DebugFunc="")
{
  l_Debug := IsFunc(p_DebugFunc) , l_StX := p_StartX , l_List := ""
  p_EndX := ( !p_EndX ? A_ScreenWidth : p_EndX ) , p_EndY := ( !p_EndY ? A_ScreenHeight : p_EndY )
  Loop
  {
    ImageSearch, l_OutX, l_OutY, %l_StX%, %p_StartY%, %p_EndX%, %p_EndY%, %p_ImgStr%
    If l_Debug
      %p_DebugFunc%(A_Index,l_OutX,l_OutY,l_StX,p_StartY,p_EndX,p_EndY,p_ImgStr,l_List)
    If InStr( l_List , l_OutX p_CDelim l_OutY p_LDelim )
    {
      l_StX := l_OutX+1
      Continue
    }   
    If ( l_OutX="" || l_OutY="" )
      If ( l_StX <> p_StartX )
      {
        l_StX := p_StartX , p_StartY++
        Continue
      }
      Else
        Break
    l_List .= l_OutX p_CDelim ( p_StartY := l_OutY ) p_LDelim
  }
  Return l_List
}
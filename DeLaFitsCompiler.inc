{ **************************************************** }
{     DeLaFits - Library FITS for Delphi & Lazarus     }
{                                                      }
{         Default compiler conditional defines         }
{                                                      }
{        Copyright(c) 2013-2016, Evgeniy Dikov         }
{              delafits.library@gmail.com              }
{        https://github.com/felleroff/delafits         }
{ **************************************************** }

// Support shared buffer for operations of data

{$IF NOT ( DEFINED(DELADATBUFSHARED) OR
           DEFINED(DELADATBUFPRIVATE) OR
           DEFINED(DELADATBUFTEMP) )}
  {$DEFINE DELADATBUFSHARED}
{$IFEND}

// Support all BitPix: -64, -32, 08, 16, 32, 64

{$IF NOT ( DEFINED(DELABITPIX64F) OR DEFINED(DELABITPIX32F) OR
           DEFINED(DELABITPIX08U) OR DEFINED(DELABITPIX16C) OR
           DEFINED(DELABITPIX32C) OR DEFINED(DELABITPIX64C) )}
  {$DEFINE DELABITPIX64F}
  {$DEFINE DELABITPIX32F}
  {$DEFINE DELABITPIX08U}
  {$DEFINE DELABITPIX16C}
  {$DEFINE DELABITPIX32C}
  {$DEFINE DELABITPIX64C}
{$IFEND}


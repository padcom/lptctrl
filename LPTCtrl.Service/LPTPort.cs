using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Http;

namespace LPTCtrl.Service
{
    class LPTPort : MarshalByRefObject
    {
        [DllImport("inpout32.dll", EntryPoint = "Inp32")]
        private static extern int Input(int adress);

        [DllImport("inpout32.dll", EntryPoint = "Out32")]
        private static extern void Output(int adress, int value);

        public static LPTPort Default = new LPTPort();

        public int Get()
        {
            return Input(0x378);
        }

        public void Set(int value)
        {
            Output(0x378, value);
        }

        public bool GetBit(int bit)
        {
            return (Get() & (1 << bit)) != 0;
        }

        public void SetBit(int bit, bool value)
        {
            if (value)
                Set(Get() | (1 << bit));
            else
                Set(Get() & ~(1 << bit));
        }

        public void ToggleBit(int bit)
        {
            SetBit(bit, !GetBit(bit));
        }
    }
}

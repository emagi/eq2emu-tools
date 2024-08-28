using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SlimDX;

namespace EQ2ModelViewer
{
    class ModelVertexMap
    {
        public ModelVertexMap()
        {

        }
        public List<Vector3> Verts = new List<Vector3>();
        public UInt32 WidgetID = 0;
        public Vector3 Position = new Vector3(0.0f, 0.0f, 0.0f);

    }
}

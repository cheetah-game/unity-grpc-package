using Grpc.Core;
using Grpc.Service;
using UnityEngine;

public class GRPCExample : MonoBehaviour
{
    void Start()
    {
        var channel = new Channel("127.0.0.1:5001", ChannelCredentials.Insecure);
        var client = new Game.GameClient(channel);
        var position = new Vector3d {X = 100, Y = 200, Z = 300};
        var vector3d = client.SetPosition(position, Metadata.Empty);
        Debug.Log("result " + vector3d.X + " " + vector3d.Y + " " + vector3d.Z);
    }


    void Update()
    {
    }
}
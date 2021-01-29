using Grpc.Core;
using Grpc.Service;
using UnityEngine;
using UnityEngine.UI;

public class GRPCExample : MonoBehaviour
{
    [SerializeField] private Text text;

    private NumberValue position = new NumberValue();
    private Game.GameClient client;


    void Start()
    {
        position.Value = 0;
        var channel = new Channel("192.168.212.97:5001", ChannelCredentials.Insecure);
        client = new Game.GameClient(channel);
    }


    async void Update()
    {
        position = client.Increment(position);
        position = await client.IncrementAsync(position, new CallOptions());
        if (!text.IsDestroyed())
        {
            text.text = position.Value.ToString();
        }
    }
}
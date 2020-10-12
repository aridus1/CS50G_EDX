using UnityEngine;
using System.Collections;
using System.Collections.Generic;


public class GemSpawner : MonoBehaviour
{
	public GameObject[] prefabs;
    // Start is called before the first frame update
    void Start()
    {

		//infinite gem spawning function, asynchronus
		StartCoroutine(SpawnGems());
    }

    // Update is called once per frame
    void Update()
    {
        
    }

	IEnumerator SpawnGems()
	{
		while (true)
		{
			// number of gems we could spawn vertically
			int gemsThisRow = 1;

			// instantiate all coins in this row separated by some amount of space
			for(int i = 0; i < gemsThisRow; i++)
			{
				Instantiate(prefabs[Random.Range(0, prefabs.Length)], new Vector3(26, Random.Range(-10, 10), 10), Quaternion.identity);
			}

			// pause 1-5 seconds until the next coin spawns
			yield return new WaitForSeconds(Random.Range(4, 20));
		}
	}
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Gem : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
		// Despawn if  moving past left edge
		if (transform.position.x < -25)
		{
			Destroy(gameObject);
		}
		else
		{
			transform.Translate(-SkyscraperSpawner.speed * Time.deltaTime,
				 0, 0, Space.World);
		}

		transform.Rotate(0, 5f, 0, Space.World);
	}

	void OnTriggerEnter(Collider other)
	{
		other.transform.parent.GetComponent<HeliController>().PickupGem();
		Destroy(gameObject);
	}
}
